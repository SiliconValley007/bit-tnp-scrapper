package org.debjeetdas;

import com.google.api.core.ApiFuture;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.*;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.FirestoreClient;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Database {

    // Replace "your-collection-name" with the actual name of your Firestore collection.
    private static final String JOB_COLLECTION_NAME = "jobs";
    private static final String NOTIFY_COLLECTION_NAME = "notifications";
    private static final String JOB_DETAILS_COLLECTION_NAME = "job-details";

    private static Firestore firestore;

    // Get a reference to the Fire-store collection
    private static CollectionReference jobCollectionRef;
    private static CollectionReference notifyCollectionRef;
    private static CollectionReference jobDetailsCollectionRef;

    private Database() {}

    private static CollectionReference getCurrentCollectionRef(Collection collection) {
        if(collection == Collection.JOBS) return jobCollectionRef;
        return notifyCollectionRef;
    }

//    public static void uploadJobDetails(String id, Map<String, Object> data) {
//        jobDetailsCollectionRef.document(id).set(data);
//    }

    public static void uploadJobDetails(List<Map<String, Map<String, Object>>> data) {
        WriteBatch batch = firestore.batch();
        for(Map<String, Map<String, Object>> map: data) {
            for(String docId: map.keySet()) {
                Map<String, Object> details = map.get(docId);
                //Extract courses list from details map
                final Map<String, Object> eligibility = (Map<String, Object>) details.get("eligibility");
                List<String> courses = (List<String>) eligibility.get("courses");
                DocumentReference docRef = jobCollectionRef.document(docId);
                batch.update(docRef, "courses", courses);
            }
        }
        batch.commit();
        System.out.println("Jobs updated successfully with course list");

        batch = firestore.batch();
        for(Map<String, Map<String, Object>> map: data) {
            for(String docId: map.keySet()) {
                final Map<String, Object> details = map.get(docId);
                jobDetailsCollectionRef.document(docId).set(details);
            }
        }

        // Commit the batched write
        final ApiFuture<List<WriteResult>> result = batch.commit();

        try {
            // Wait for the batch write to complete
            result.get();
            System.out.println("Batch write completed successfully.");
        } catch (Exception e) {
            System.err.println("Error performing batch write: " + e.getMessage());
        }
    }

    public static Map<String, String> uploadDataList(List<Map<String, String>> data, Collection collection) {
        final CollectionReference currentCollectionRef = getCurrentCollectionRef(collection);
        Map<String, String> jobDescriptions = new HashMap<>(data.size());
        try {
            System.out.println("Starting upload to cloud db ... ");
            // Create a list to store the batch writes
            List<WriteBatch> batches = new ArrayList<>();
            WriteBatch currentBatch = currentCollectionRef.getFirestore().batch();
            batches.add(currentBatch);

            final int batchSizeLimit = 500; // Set an appropriate batch size limit

            // Iterate through dataList and upload each map as a separate document
            for (Map<String, String> currentData: data) {
                DocumentReference newDocRef = currentCollectionRef.document();

                // Optionally, check if the document with the same data already exists to avoid unnecessary writes
                // ...

                // Add the data to the current batch
                currentBatch.set(newDocRef, currentData);
                if(collection == Collection.JOBS) {
                    final String url = currentData.get("viewAndApply");
                    if(url != null && !url.isBlank()) {
                        jobDescriptions.put(newDocRef.getId(), Util.BASE_URL + url);
                    }
                }

                // If the current batch size reaches the limit, create a new batch
                if (currentBatch.getMutationsSize() >= batchSizeLimit) {
                    currentBatch = currentCollectionRef.getFirestore().batch();
                    batches.add(currentBatch);
                }
            }

            // Execute the batch writes
            for (WriteBatch batch : batches) {
                ApiFuture<List<WriteResult>> batchFuture = batch.commit();
                try {
                    batchFuture.get();
                } catch (Exception e) {
                    System.err.println("Error writing batch: " + e.getMessage());
                }
            }
            System.out.println("Upload successful");
            return jobDescriptions;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error uploading data to cloud database");
            return null;
        }
    }

    public static void delete(Map<String, String> document, Collection collection) {
        final CollectionReference currentCollectionRef = getCurrentCollectionRef(collection);
        Query query = currentCollectionRef.whereEqualTo("Updates", document.get("Updates"));

        // Get the query snapshot
        ApiFuture<QuerySnapshot> querySnapshot = query.get();
        try {
            QuerySnapshot snapshot = querySnapshot.get();

            // Loop through the documents that match the target data and delete them
            for (QueryDocumentSnapshot doc : snapshot) {
                doc.getReference().delete();
                System.out.println("Document deleted: " + doc.getId());
            }
        } catch (Exception e) {
            System.err.println("Error deleting documents: " + e.getMessage());
        }
    }

    public static void initializeDB() {
        try {
            System.out.println("Initializing cloud database ... ");
            // Load the service account key from the resources folder in the JAR.
            final FileInputStream serviceAccount =
                    new FileInputStream("src/main/resources/tnpscrapper-firebase-adminsdk-cettk-5dec6a3a67.json");

            // Initialize Firebase Admin SDK with the credentials.
            final FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .build();

            FirebaseApp.initializeApp(options);
            firestore = FirestoreClient.getFirestore();
            jobCollectionRef =  firestore.collection(JOB_COLLECTION_NAME);
            notifyCollectionRef = firestore.collection(NOTIFY_COLLECTION_NAME);
            jobDetailsCollectionRef = firestore.collection(JOB_DETAILS_COLLECTION_NAME);
            System.out.println("Cloud database successfully instantiated");
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Error initializing cloud database. Exiting ...");
            System.exit(1);
        }
    }

    public static void dispose() {
        try {
            firestore.close();
            System.out.println("Cloud database resources released");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error releasing cloud database resources.");
        }
    }
}
