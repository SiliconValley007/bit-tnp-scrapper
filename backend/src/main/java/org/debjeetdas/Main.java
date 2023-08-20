package org.debjeetdas;

import org.fusesource.jansi.AnsiConsole;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class Main {

    private static final String JOB_LISTINGS_URL = "https://tp.bitmesra.co.in/applyjobs.html";

    private static final String NEWS_EVENTS_URL = "https://tp.bitmesra.co.in/newsevents";


    public static void main(String[] args) {
        //Initialize jansi for Windows command prompt
        AnsiConsole.systemInstall();
        Util.waitForInternetConnectivity();
        CookieManager.generateCookies();
        Database.initializeDB();
        Runnable jobRunnable = () -> {
            // retrieve and save jobs
            final Element response = Util.accessRestrictedPage(JOB_LISTINGS_URL);
            final Elements tableRows = JobListingsScrapper.filterJobListings(response);
            final List<Map<String, String>> dataList = JobListingsScrapper.extractJobListings(tableRows);
            Storage.filterAndSave(dataList, Collection.JOBS);
            System.out.println("> Refreshing job listings after 5 minutes ...\n");
        };

        ScheduledExecutorService jobService = Executors.newSingleThreadScheduledExecutor();
        jobService.scheduleAtFixedRate(jobRunnable, 0 , 5, TimeUnit.MINUTES);

        Runnable notificationRunnable = () -> {
            // retrieve and save notifications
            System.out.println("Updating Notifications.");
            final Element notificationResponse = Util.accessRestrictedPage(NEWS_EVENTS_URL);
            final Elements rows = NotificationScrapper.filterNotifications(notificationResponse);
            List<Map<String, String>> news = NotificationScrapper.extractDataFromRow(rows);
            for(Map<String, String> curr: news) {
                NotificationScrapper.extractNotificationData(curr);
            }
            Storage.filterAndSave(news, Collection.NOTIFICATIONS);
            System.out.println("Notifications updated successfully");
            System.out.println("Refreshing notifications after 1 minute...\n");
        };

        ScheduledExecutorService notificationService = Executors.newSingleThreadScheduledExecutor();
        notificationService.scheduleAtFixedRate(notificationRunnable, 0 , 1, TimeUnit.MINUTES);




        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            System.out.println("Disposing off resources ...");
            Database.dispose();
            //Reset jansi on shutdown
            AnsiConsole.systemUninstall();
            System.out.println("Shutting down. Bye byeee ... :)");
        }));
    }
}