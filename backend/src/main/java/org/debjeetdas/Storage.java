package org.debjeetdas;

import com.google.cloud.firestore.CollectionReference;

import java.io.*;
import java.util.*;

public class Storage {

    private static final String JOBS_FILENAME = "tnpscrapper_joblistings.ser";
    private static final String NOTIFY_FILENAME = "tnpscrapper_notifications.ser";

    private Storage() {}

    private static String getCurrentFilename(Collection collection) {
        if(collection == Collection.JOBS) return JOBS_FILENAME;
        return NOTIFY_FILENAME;
    }

    public static void saveDataToLocal(List<Map<String, String>> data, Collection collection) {
        final String CURRENT_FILENAME = getCurrentFilename(collection);
        try (ObjectOutputStream outputStream = new ObjectOutputStream(new FileOutputStream(CURRENT_FILENAME))) {
            outputStream.writeObject(data);
            System.out.println("Contents saved to file successfully");
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Error writing to file on local storage.");
        }
    }

    @SuppressWarnings("unchecked")
    public static List<Map<String, String>> readDataListFromFile(Collection collection) {
        final String CURRENT_FILENAME = getCurrentFilename(collection);
        List<Map<String, String>> dataList = new ArrayList<>();
        try (ObjectInputStream inputStream = new ObjectInputStream(new FileInputStream(CURRENT_FILENAME))) {
            dataList = (List<Map<String, String>>) inputStream.readObject();
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return dataList;
    }

    public static void filterAndSave(List<Map<String, String>> data, Collection collection) {
        System.out.println("Sorting and saving data ...");
        final List<Map<String, String>> savedData = readDataListFromFile(collection);

        if(Util.areListsEqual(data, savedData)) {
            System.out.println("No change in data. No saving needed.");
            return;
        }

        List<Map<String, String>> newDataList = new ArrayList<>();
        List<Map<String, String>> removedItemsList = new ArrayList<>();

        // Convert savedData to a HashMap for faster lookup
        Map<Map<String, String>, Boolean> savedDataMap = new HashMap<>();
        for (Map<String, String> savedMap : savedData) {
            savedDataMap.put(savedMap, true);
        }

        Map<Map<String, String>, Boolean> originalDataMap = new HashMap<>();
        for (Map<String, String> map : data) {
            originalDataMap.put(map, true);
        }

        for (Map<String, String> curr : data) {
            if (!savedDataMap.containsKey(curr)) {
                newDataList.add(curr);
            }
        }

        for (Map<String, String> curr : savedData) {
            if (!originalDataMap.containsKey(curr)) {
                removedItemsList.add(curr);
            }
        }

        saveDataToLocal(data, collection);
        if(removedItemsList.size() != 0) {
            System.out.println("Items to be removed: ");
            for(Map<String, String> item: removedItemsList) {
                System.out.println(item);
                // UPDATE LOGIC FOR NOTIFY AND JOB
                Database.delete(item, collection);
            }
        }
        if(newDataList.size() != 0) {
            System.out.println("New items being added are:");
            for(Map<String, String> item: newDataList) {
                System.out.println(item);
            }
            final Map<String, String> ids = Database.uploadDataList(newDataList, collection);
            if(ids != null && !ids.isEmpty() && collection == Collection.JOBS) {
                List<Map<String, Map<String, Object>>> jobDetails = new ArrayList<>(ids.size());
                for (String key : ids.keySet()) {
                    final String value = ids.get(key);
                    final Map<String, Object> details = JobDescriptionParser.extractJobDescription(value);
                    final Map<String, Map<String, Object>> jobDetailMap = new HashMap<>();
                    jobDetailMap.put(key, details);
                    jobDetails.add(jobDetailMap);
                }
                Database.uploadJobDetails(jobDetails);
            }
        }
        System.out.println("Data saved successfully");
    }

}
