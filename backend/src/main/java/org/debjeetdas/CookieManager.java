package org.debjeetdas;

import org.jsoup.Connection;
import org.jsoup.Jsoup;

import java.util.HashMap;
import java.util.Map;
import java.util.prefs.BackingStoreException;
import java.util.prefs.Preferences;

public class CookieManager {

    private static final Preferences prefs = Preferences.userRoot().node(Main.class.getName());
    private static Map<String, String> cookies;
    private static final String LOGIN_URL = "https://tp.bitmesra.co.in/login.html";
    private static final Map<String, String> loginData = Map.of(
            "identity", "TPBIT-MCA1004022",
            "password", "6039616b",
            "submit", "Login"
    );

    private CookieManager() {}

    public static Map<String, String> getCookies() {
        return cookies;
    }

    public static void generateCookies() {
        System.out.println("Loading login cookie ... ");
        Map<String, String> cookie = CookieManager.loadCookies();
        if(cookie == null) {
            System.out.println("Cookie not found in local storage.\n\tTrying to get new cookie ... ");
            cookie = login();
            if(cookie == null) {
                System.out.println("Login failed, please check credentials and try again");
                System.exit(0);
            } else {
                System.out.println("New cookie successfully generated. Saving to local storage ... ");
                CookieManager.clearCookies();
                CookieManager.storeCookies(cookie);
            }
        }
        System.out.println("Cookies successfully generated.");
        cookies = cookie;
    }

    private static Map<String, String> login() {
        try {
//            // Perform login and access the restricted page
//            Map<String, String> loginData = new HashMap<>(3);
//            loginData.put("identity", USERNAME);
//            loginData.put("password", PASSWORD);
//            loginData.put("submit", "Login");

            // Step 1: Send a POST request to the login URL with the login credentials
            final Connection.Response loginResponse = Jsoup.connect(LOGIN_URL)
                    .userAgent("Mozilla/5.0 (iPad; CPU OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148")
                    .data(loginData)
                    .method(Connection.Method.POST)
                    .execute();
            System.out.println(loginResponse.cookies());
            return loginResponse.cookies();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private static void storeCookies(Map<String, String> cookie) {
        try {
            for (Map.Entry<String, String> entry : cookie.entrySet()) {
                prefs.put(entry.getKey(), entry.getValue());
            }
            prefs.flush();
        } catch (BackingStoreException e) {
            e.printStackTrace();
        }
    }

    private static Map<String, String> loadCookies() {
        try {
            String[] keys = prefs.keys();
            if(keys.length == 0) return null;
            Map<String, String> currentCookies = new HashMap<>();
            for (final String key : keys) {
                currentCookies.put(key, prefs.get(key, null));
            }
            return currentCookies;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void clearCookies() {
        try {
            prefs.clear(); // This will clear all the preferences stored in the node
            prefs.flush();
        } catch (BackingStoreException e) {
            e.printStackTrace();
        }
    }
}
