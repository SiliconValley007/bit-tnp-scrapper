import 'package:flutter/material.dart';
import 'package:tnp_scanner/constants/constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const SettingsPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Item(
            text: "Courses",
            onPressed: () =>
                Navigator.pushNamed(context, AppStrings.courseSelection),
          ),
          const SizedBox(height: 16),
          _Item(
            text: "Credentials",
            onPressed: () =>
                Navigator.pushNamed(context, AppStrings.credentials),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    this.onPressed,
    required this.text,
  });

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(16),
        child: Text(text),
      ),
    );
  }
}
