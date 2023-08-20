import 'package:flutter/material.dart';

const int paginationSize = 12;
const int scrollEndSize = paginationSize - 2;

//Strings
const String gilroy = "Gilroy";
const String baseUrl = "https://tp.bitmesra.co.in/";

//Colors
const Color red = Color(0xffFF4343);
const Color green = Color(0xff4ABB00);
const Color offWhite = Color(0xffF6F6F6);

//abbreviation map
Map<String, String> abbreviationMap = {
  'BTech - Computer Science & Engineering': 'BTech - CS & E',
  'BTech - Information Technology': 'BTech - IT',
  'BTech - Electrical & Electronics Engineering': 'BTech - EEE',
  'BTech - Electronics & Communication Engineering': 'BTech - ECE',
  'MTech - Computer Science & Engineering': 'MTech - CS & E',
  'MTech - Information Technology': 'MTech - IT',
  'MTech - EE - Control System': 'MTech - EE - CS',
  'MTech - EE - Power Electronics': 'MTech - EE - PE',
  'MTech - EE - Power System': 'MTech - EE - PS',
  'MTech - EC - Instrumentation & Contro Engineering': 'MTech - EC - I&C E',
  'MTech - EC - Microwave Engineering': 'MTech - EC - ME',
  'MTech - EC - Wireless Communication': 'MTech - EC - WC',
  'MTech - Mechanical Engineering': 'MTech - Mech E',
  'MTech - Mechanical - Computer Aided Analysis & Design':
      'MTech - Mech - CAAD',
  'MTech - Mechanical - Design of Mechanical Equipment': 'MTech - Mech - DME',
  'MTech - Mechanical - Energy Technology': 'MTech - Mech - ET',
  'MTech - Mechanical - Heat Power': 'MTech - Mech - HP',
  'BTech - Biotechnology': 'BTech - BT',
  'BTech - Chemical Engineering': 'BTech - Chem E',
  'BTech - Chemical Engineering - Plastics & Polymer': 'BTech - Chem E - P&P',
  'BTech - Civil Engineering': 'BTech - Civil E',
  'BTech - Mechanical Engineering': 'BTech - Mech E',
  'BTech - Production & Industrial Engineering': 'BTech - P&I E',
  'IMSc - Maths & Computing': 'IMSc - Maths & Comp',
  'MCA - Computer Application': 'MCA',
  'MTech - Information Security': 'MTech - InfoSec',
  'MBA - Business Analytics & IT': 'MBA - BA & IT',
  'MBA - Business Analytics & Finance': 'MBA - BA & Fin',
  'MBA - Human Resource & Finance': 'MBA - HR & Fin',
  'MBA - IT & Finance': 'MBA - IT & Fin',
  'MBA - Business Analytics & Human Resource': 'MBA - BA & HR',
  'MBA - IT & Human Resource': 'MBA - IT & HR',
  'MBA - Marketing & Business Analytics': 'MBA - Mkt & BA',
  'MBA - Marketing & Finance': 'MBA - Mkt & Fin',
  'MBA - Marketing & Human Resource': 'MBA - Mkt & HR',
  'MBA - Marketing & IT': 'MBA - Mkt & IT',
  'MBA - Human Resource & Operation': 'MBA - HR & Ops',
  'MBA - Marketing & Operations': 'MBA - Mkt & Ops',
  'MBA - Operations & Finance': 'MBA - Ops & Fin',
  'MBA - Business Analytics & Operations': 'MBA - BA & Ops',
  'MBA - Operations & IT': 'MBA - Ops & IT',
  'MBA - NA': 'MBA - NA',
  'IMSc - Chemistry': 'IMSc - Chem',
  'IMSc - Food Technology': 'IMSc - Food Tech',
  'IMSc - Physics': 'IMSc - Phys',
  'MTech - Civil - Soil Mechanics & Foundation Engineering':
      'MTech - Civil - Soil Mech & FE',
  'MTech - Civil - Structural Engineering': 'MTech - Civil - Struct Eng.',
  'MTech - Production & Industrial Engineering': 'MTech - P&I E',
  'MTech - Biotechnology': 'MTech - BT',
  'MTech - Environmental Science & Engineering': 'MTech - Env Sci & Eng',
  'MTech - Remote Sensing': 'MTech - RS',
  'MTech - Space Engineering & Rocketry - Aerodynamics':
      'MTech - SE & R - Aero',
  'MTech - Space Engineering & Rocketry - Rocket Propulsion':
      'MTech - SE & R - Rocket Prop',
};

abstract class AppStrings {
  static const String home = '/';
  static const String settings = '/settings';
  static const String courseSelection = '/course-selection';
  static const String jobDetails = '/job-details';
  static const String webView = '/web-view';
  static const String credentials = '/credentials';
}

String filterUrl(String url) {
  if (url.startsWith('.')) {
    return url.substring(1);
  }
  return url;
}

List<String> cleanText(String text) {
  // Remove HTML tags using regular expression
  String cleanText = text.replaceAll(RegExp(r'<.*?>'), '');
  return cleanText.trim().split('\n');
}
