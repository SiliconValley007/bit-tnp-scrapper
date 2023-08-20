import 'package:flutter/material.dart';
import 'package:tnp_scanner/pages/credentials/credentials_page.dart';
import 'package:tnp_scanner/pages/home/model/job_detail_argument.dart';
import 'package:tnp_scanner/pages/web_view_page.dart';

import '../constants/constants.dart';
import '../pages/course_selection/course_selection_page.dart';
import '../pages/home/home_page.dart';
import '../pages/job_details_page.dart';
import '../pages/settings/settings_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppStrings.home:
        return HomePage.route();
      case AppStrings.settings:
        return SettingsPage.route();
      case AppStrings.courseSelection:
        return CourseSelectionPage.route();
      case AppStrings.credentials:
        return CredentialsPage.route();
      case AppStrings.webView:
        return WebViewPage.route(url: routeSettings.arguments as String?);
      case AppStrings.jobDetails:
        return JobDetailsScreen.route(
            id: routeSettings.arguments as JobDetailArgument);
      default:
        return HomePage.route();
    }
  }
}
