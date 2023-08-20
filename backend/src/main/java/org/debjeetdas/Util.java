package org.debjeetdas;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import java.io.IOException;
import java.net.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class Util {

    private Util() {}

    public static final String delimiter = "||";
    public static final String BASE_URL = "https://tp.bitmesra.co.in/";

    public static <T> boolean areListsEqual(List<T> list1, List<T> list2) {
        if(list1 == null || list2 == null) {
            return false;
        }
        final int list1Size = list1.size();
        final int list2Size = list2.size();
        // Step 1: Check if sizes are equal
        if (list1Size != list2Size) {
            return false;
        }

        // Step 2: Compare each corresponding element
        for (int i = 0; i < list1Size; i++) {
            T element1 = list1.get(i);
            T element2 = list2.get(i);

            if (!element1.equals(element2)) {
                return false;
            }
        }

        // Step 3: If no differences found, lists are equal
        return true;
    }

    public static void waitForInternetConnectivity() {
        int tries = 0;
        System.out.println("Checking for internet connectivity...");
        while (true) {
            if (hasInternetConnectivity()) {
                System.out.println("Connection successfully established");
                return;
            }
            System.out.println("No internet connectivity, retrying " + tries++);
            // Wait for the next interval using a custom method
            waitWithoutBlocking(5000);
        }
    }

    private static boolean hasInternetConnectivity() {
        try {
            InetAddress.getByName("www.google.com");
            return true;
        } catch (IOException ignored) {
            return false;
        }
    }

    private static void waitWithoutBlocking(long millis) {
        // A custom method to wait without blocking the current thread
        long targetTime = System.currentTimeMillis() + millis;
        while (System.currentTimeMillis() < targetTime) {
            // Empty loop to wait without blocking
        }
    }

    public static String convertToFireStoreDate(String dateString) {
        DateFormat inputFormat = new SimpleDateFormat("dd/MM/yyyy");
        DateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date date = inputFormat.parse(dateString);
            return outputFormat.format(date);
        } catch (ParseException e) {
            System.err.println("Error parsing date: " + e.getMessage());
            return null;
        }
    }
    /// Returns the body of the scrapped url
    public static Element accessRestrictedPage(String url) {
        try {
            System.out.println("Logging you in ... ");
            final Document restrictedDocument = Jsoup.connect(url)
                    .cookies(CookieManager.getCookies()) // Use the stored cookies for each request
                    .get();
            System.out.println("Login successful. Accessing page ... ");
            return restrictedDocument.body();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error accessing protected page. Please recheck cookies OR authentication.");
            return null;
        }
    }

    public static String extractTableName(Element table) {
        Element heading = table.selectFirst("thead tr td b");
        if(heading == null) {
            heading = table.selectFirst("tbody tr td b");
        }
        return heading.text();
    }

    public static boolean compareStrings(String str1, String str2) {
        // Remove whitespaces and convert both strings to lowercase
        String cleanStr1 = str1.replaceAll("\\s", "").toLowerCase();
        String cleanStr2 = str2.replaceAll("\\s", "").toLowerCase();

        // Compare the cleaned strings
        return cleanStr1.equals(cleanStr2);
    }
}
