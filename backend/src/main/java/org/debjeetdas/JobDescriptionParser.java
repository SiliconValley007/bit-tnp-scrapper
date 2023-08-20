package org.debjeetdas;

import org.jsoup.nodes.Element;
import org.jsoup.nodes.Node;
import org.jsoup.select.Elements;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class JobDescriptionParser {
    
    public static Map<String, Object> extractJobDescription(String url) {
        final Elements tables =  JobDescriptionParser.extractJobDescriptionTables(url);
        System.out.println("Starting extraction of url: " + url);
        Map<String, Object> jobDescriptionMap = new HashMap<>();
        for(int i = 0; i < tables.size(); i++) {
            final Element currentTable = tables.get(i);
            if(i == 0) {
                final String postedBy = JobDescriptionParser.postedBy(currentTable.selectFirst("tr"));
                jobDescriptionMap.put("postedBy", postedBy);
                continue;
            }
            final String currentTableName = Util.extractTableName(currentTable);
            if(Util.compareStrings(currentTableName, "REGISTRATION")) {
                final Map<String, String> registrationDetails = JobDescriptionParser.registrationDetails(currentTable.select("tr").get(1));
                jobDescriptionMap.put("registrationDetails", registrationDetails);
            } else if (Util.compareStrings(currentTableName, "JOB PROFILE DETAILS")) {
                final Map<String, Object> jobProfileDetails = JobDescriptionParser.jobProfileDetails(currentTable.select("tbody tr td"));
                jobDescriptionMap.put("jobProfileDetails", jobProfileDetails);
            } else if (Util.compareStrings(currentTableName, "SALARY DETAILS - FTE")) {
                final Elements body = currentTable.select("tbody tr");
                final  Map<String, List<String>> salaryDetails = JobDescriptionParser.salaryDetails(currentTable.select("thead tr").last(), body);
                jobDescriptionMap.put("salaryDetails", salaryDetails);
                final String remarks = JobDescriptionParser.salaryRemarks(body);
                if(remarks != null) {
                    jobDescriptionMap.put("salaryDetailsRemarks", remarks);
                }
            } else if (Util.compareStrings(currentTableName, "STIPEND DETAILS - INTERNSHIP")) {
                final  Map<String, String> stipendDetails = JobDescriptionParser.stipendDetails(currentTable.select("tr"));
                jobDescriptionMap.put("stipendDetails", stipendDetails);
            } else if (Util.compareStrings(currentTableName, "SELECTION PROCESS")) {
                final List<String> selectionProcess = JobDescriptionParser.selectionProcess(currentTable.select("tbody tr td"));
                jobDescriptionMap.put("selectionProcess", selectionProcess);
            } else if (Util.compareStrings(currentTableName, "ELIGIBILITY")) {
                final Map<String, Object> eligibility = JobDescriptionParser.extractEligibilityInfo(currentTable.selectFirst("tbody tr td"));
                jobDescriptionMap.put("eligibility", eligibility);
            } else if (Util.compareStrings(currentTableName, "COMPANY DETAILS")) {
                final Map<String, String> companyDetails = JobDescriptionParser.companyDetails(currentTable.select("tbody tr td"));
                jobDescriptionMap.put("companyDetails", companyDetails);
            }
        }
        return jobDescriptionMap;
    }

    private static Elements extractJobDescriptionTables(String url) {
        Element response = Util.accessRestrictedPage(url);
        return response.select("table:not(.print_table)");
    }
    private static String postedBy(Element tr) {
        StringBuilder result = new StringBuilder();
        Element td = tr.selectFirst("td[align=right]");
        Elements paragraphs = td.select("p");
        for(Element p: paragraphs) {
            final String currentText = p.text();
            if(!currentText.isBlank()) {
                result.append(p.text()).append(Util.delimiter);
            }
        }
        return result.toString();
    }

    private static Map<String, String> registrationDetails(Element tr) {
        Map<String, String> map = new HashMap<>();
        Element startsFromElement = tr.selectFirst("td:contains(Starts From)");
        map.put("startsFrom", startsFromElement.text());
        Element endsOnElement = tr.selectFirst("td:contains(Ends On)");
        map.put("endsOn", endsOnElement.text());
        return map;
    }

    private static Map<String, Object> jobProfileDetails(Elements tds) {
        Map<String, Object> map = new HashMap<>();
        Map<String, String> currentMap = new HashMap<>();
        for (Element td : tds) {
            final String currentText = td.text().trim();
            if (currentText.equalsIgnoreCase("Internship")) {
                if(!currentMap.isEmpty()) {
                    map.put("fullTimeEmployment", currentMap);
                    currentMap.clear();
                }
            }
            if(currentText.equalsIgnoreCase("Job Designation")) {
                currentMap.put(currentText, td.nextElementSibling().text());
            }
            Element tdElement = tds.select("td:contains(Type)").first();
            if (tdElement != null) {
                currentMap.put("type", tdElement.nextElementSibling().text());
            }
            if(currentText.equalsIgnoreCase("Job Description")) {
                final Element nextTd = td.nextElementSibling();
                currentMap.put(currentText, nextTd.text());
                final Element aTag = nextTd.selectFirst("a");
                if(aTag != null) {
                    String hrefLink = aTag.attr("href");
                    currentMap.put("jobDescriptionLink", hrefLink);
                }
            }
            if(currentText.equalsIgnoreCase("Place of Posting")) {
                currentMap.put(currentText, td.nextElementSibling().text());
            }
        }
        map.put("internship", currentMap);
        return map;
    }

    private static Map<String, List<String>> salaryDetails(Element head, Elements body) {
        Map<String, List<String>> pgMap = new HashMap<>();
        Elements headers = head.select("td");
        for(Element header: headers) {
            pgMap.put(header.text(), new ArrayList<>());
        }
        for(Element row: body) {
            Elements cells = row.select("td");
            if(cells.size() == pgMap.size()) {
                int i = 0;
                for(Element cell: cells) {
                    final String headerText = headers.get(i++).text();
                    pgMap.get(headerText).add(cell.text());
                }
            }
        }
        return pgMap;
    }

    private static String salaryRemarks(Elements body) {
        Element remarks = body.select("tr td b:contains(Remarks:)").first();
        if(remarks != null) {
            Node next = remarks.nextSibling();
            if(next != null) {
                return next.toString().trim();
            }
        }
        return null;
    }

    private static Map<String, String> stipendDetails(Elements rows) {
        Elements tds = rows.select("td");
        final int tdsSize = tds.size();
        if(!tds.first().text().equalsIgnoreCase("STIPEND DETAILS - INTERNSHIP")) return null;
        // Initialize variables to store the data
        boolean skipFirstTd = true;
        String currentCourse = "ug";
        String currentBenefit = "ugBenefits";
        Map<String, String> dataMap = new HashMap<>();

        // Iterate over the td elements
        for (Element td : tds) {
            if (skipFirstTd) {
                skipFirstTd = false;
                continue;
            }

            String text = td.text();
            if(text.contains("PG")) {
                currentCourse = "pg";
                currentBenefit = "pgBenefits";
            }
            Element bTag = td.selectFirst("b");
            if(text.contains("Other Benefits")) {
                dataMap.put(currentBenefit, bTag.text());
            } else {
                dataMap.put(currentCourse, bTag.text());
            }


        }
        return dataMap;
    }

    private static List<String> selectionProcess(Elements rows) {
        List<String> elements = new ArrayList<>(rows.size());
        boolean isFirst = true;
        for (Element row: rows
             ) {
            if(isFirst) {
                isFirst = false;
                continue;
            }
            elements.add(row.text());
        }
        return elements;
        // eligibility
    }

    private static Map<String, Object> extractEligibilityInfo(Element td) {
        Map<String, Object> eligibilityMap = new HashMap<>();

        // Extract courses
        Elements courseElements = td.select("div.px-2.py-1.rounded.d-inline-block.border.border-light");
        List<String> courses = new ArrayList<>();
        for (Element courseElement : courseElements) {
            courses.add(courseElement.text());

        }
        eligibilityMap.put("courses", courses);
        Map<String, String> criteria = new HashMap<>();
        Elements bTags = td.select("b");
        for(Element b: bTags) {
            Node nextSibling = b.nextSibling();
            if(nextSibling != null) {
                final String value = nextSibling.toString().trim();
                final String key = b.text();
                criteria.put(key, value);
            }
        }
        if(!criteria.isEmpty()) {
            eligibilityMap.put("criteria", criteria);
        }

        Element additionalCriteriaElement = td.selectFirst("h5.mt-2");
        Node nextSibling = additionalCriteriaElement.nextSibling();
        if(nextSibling != null) {
            String additionalCriteria = nextSibling.toString().trim();
            eligibilityMap.put("additionalCriteria", additionalCriteria);
        }
        return eligibilityMap;
    }

    private static Map<String, String> companyDetails(Elements tds) {
        Map<String, String> resultMap = new HashMap<>();
        final int tdsSize = tds.size();
        for (int i = 0; i < tdsSize; i += 2) {
            String key = tds.get(i).text();
            String value = "";
            if(i+1 < tdsSize) {
                Element valueElement = tds.get(i + 1);
                value = valueElement.text();
            }
            if(value.isBlank()) {
                String temp = key;
                key = "description";
                value = temp;
            }
            resultMap.put(key, value);
        }
        final String url = resultMap.get("URL");
        if(url != null) {
            resultMap.remove("URL");
            resultMap.put("url", url);
        }
        final String yearOfEstablishment = resultMap.get("Year of Establishment");
        if(yearOfEstablishment != null) {
            resultMap.remove("Year of Establishment");
            resultMap.put("yearOfEstablishment", yearOfEstablishment);
        }
        return resultMap;
    }

}
