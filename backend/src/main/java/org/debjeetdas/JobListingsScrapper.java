package org.debjeetdas;

import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class JobListingsScrapper {
    private JobListingsScrapper() {}

    public static List<Map<String, String>> extractJobListings(Elements tableRows) {
        System.out.println("Formatting job listings ...");
        // Initialize a list to store the maps
        List<Map<String, String>> dataList = new ArrayList<>();

        // Iterate through each <tr> element and create a map representing each row
        for (Element row : tableRows) {
            final Elements columns = row.select("td");

            if (columns.size() == 4) { // Ensure that the row has the expected number of columns
                // Create a map representing the row data
                Map<String, String> rowData = new HashMap<>();

                String company = columns.get(0).text();
                rowData.put("company", company);

                String deadline = columns.get(1).text();
                rowData.put("deadLine", Util.convertToFireStoreDate(deadline));

                String postedOn = columns.get(2).text();
                rowData.put("postedOn", Util.convertToFireStoreDate(postedOn));

                // Extract the links in the <a> tags
                final Elements links = columns.get(3).select("a");
                Map<String, String> linksMap = new HashMap<>();
                for (Element link : links) {
                    String linkText = link.text();
                    String href = link.attr("href");
                    if(linkText.equals("Updates")) {
                        linkText = "updates";
                    } else if (linkText.equals("View & Apply")) {
                        linkText = "viewAndApply";
                    }
                    linksMap.put(linkText, href);
                }

                rowData.putAll(linksMap); // Add the links map to the row data

                // Add the map to the list
                dataList.add(rowData);
            }
        }
        System.out.println("Jobs formatted successfully");
        return dataList;
    }

    public static Elements filterJobListings(Element response) {
        System.out.println("Scrapping job listing from website ...");
        if(response == null) {
            System.out.println("Could not access job listings. Some error occurred");
            System.exit(0);
        }
        String responseBody = response.outerHtml();
        if(responseBody.equals("<body></body>")) {
            System.out.println("Could not access job listings. PLease verify authentication");
            System.exit(0);
        }
        Element table = response.selectFirst("#job-listings");
        if (table == null) {
            System.out.println("Table with ID 'job-listings' not found.");
            System.exit(0);
        }
        System.out.println("Jobs fetched successfully");
        return table.select("tr");
    }
}
