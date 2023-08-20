package org.debjeetdas;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class NotificationScrapper {
    private NotificationScrapper() {}

    public static Elements filterNotifications(Element response) {
        System.out.println("Scrapping notifications from website ...");
        if(response == null) {
            System.out.println("Could not access notifications. Some error occurred");
            System.exit(0);
        }
        String responseBody = response.outerHtml();
        if(responseBody.equals("<body></body>")) {
            System.out.println("Could not access notifications. PLease verify authentication");
            System.exit(0);
        }
        return response.select("table#newsevents tbody tr");
    }

    public static List<Map<String, String>> extractDataFromRow(Elements rows) {
        List<Map<String, String>> newsEventsList = new ArrayList<>();
        for(Element row : rows) {
            Elements tdElements = row.select("td");

            Map<String, String> current = new HashMap<>();
            // Extracting data from the first <td> tag
            Element firstTd = tdElements.get(0);
            String title = firstTd.select("h6 a").text();
            current.put("title", title);
            String link = firstTd.select("h6 a").attr("href");
            current.put("link", Util.BASE_URL + link);
            String newsType = firstTd.select("b.text-secondary").text();
            current.put("newsType", newsType);

            // extracting details if any
            Element description = firstTd.selectFirst("p.p-0.py-1");
            if(description != null) {
                current.put("description", formatParagraph(description));
            }

            // Extracting data from the second <td> tag
            Element secondTd = tdElements.get(1);
            String date = secondTd.text();
            current.put("date", Util.convertToFireStoreDate(date));
            newsEventsList.add(current);
        }
        return newsEventsList;
    }

    private static String formatParagraph(Element pElement) {
        if(pElement.text().contains("<br>")) {
            StringBuilder formattedText = new StringBuilder();
            String[] names = pElement.html().split("<br>");

            for (String name : names) {
                name = Jsoup.parse(name).text().trim();
                if (!name.isEmpty()) {
                    formattedText.append(name).append("\n");
                }
            }

            return formattedText.toString().trim();
        } else {
            return pElement.text().trim();
        }
    }

    public static void extractNotificationData(Map<String, String> notificationMap) {
        final Map<String, String> cookies = CookieManager.getCookies();
        final String link = notificationMap.get("link");
        try {
            Document doc = Jsoup.connect(link).cookies(cookies).get();
            Element body = doc.body();

            // Extracting data from the inner div
            Element itemDiv = body.selectFirst("div[id^=itemc_]");
            if(itemDiv != null) {
                Element dataDiv = itemDiv.selectFirst("div.px-2.py-0.d-block");
//            String title = dataDiv.select("b").get(1).text();
                String content = dataDiv.selectFirst("p small").text();
                notificationMap.put("content", content);
                String centre = dataDiv.select("p b").get(0).text();
                notificationMap.put("centre", centre);

                // Extracting the link and text
                Element aTag = dataDiv.selectFirst("a");
                String attachmentLink = "";
                if(aTag != null) {
                    attachmentLink = aTag.attr("href");
                }
                notificationMap.put("moreInformation", attachmentLink);
                Element dateDiv = itemDiv.selectFirst("div.p-1.px-2");
                String dateTime = dateDiv.select("tt.small b").text();
                notificationMap.put("dateTime", dateTime);
            }

        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Error fetching notification details");
        }
    }
}
