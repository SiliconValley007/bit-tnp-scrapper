import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnp_scanner/cubits/cookie_cubit/cookie_cubit.dart';
import 'package:tnp_scanner/cubits/course_preference_cubit/course_preference_cubit.dart';
import 'package:tnp_scanner/cubits/course_search_cubit/course_search_cubit.dart';
import 'package:tnp_scanner/cubits/job_details_cubit/job_details_cubit.dart';
import 'package:tnp_scanner/cubits/jobs_cubit/jobs_cubit.dart';
import 'package:tnp_scanner/manager/notifications_manager.dart';

import 'constants/constants.dart';
import 'firebase_options.dart';
import 'locator.dart';
import 'manager/local_storage_manager.dart';
import 'pages/home/home_page.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationsManager.initNotifications();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CourseSearchCubit>(
          create: (_) => CourseSearchCubit(),
        ),
        BlocProvider<JobsCubit>(
          create: (context) =>
              JobsCubit(searchCubit: context.read<CourseSearchCubit>()),
        ),
        BlocProvider<JobDetailsCubit>(
          create: (context) => JobDetailsCubit(),
        ),
        BlocProvider<CoursePreferenceCubit>(
          create: (context) => CoursePreferenceCubit(),
        ),
        BlocProvider<CookieCubit>(
          create: (context) => CookieCubit(),
        ),
      ],
      child: const _MaterialApp(),
    );
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CookieCubit, CookieState>(
      listener: (context, state) {
        log(state.toString());
      },
      child: MaterialApp(
        title: 'BIT | TNP',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: gilroy,
          scaffoldBackgroundColor: offWhite,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        home: const HomePage(),
      ),
    );
  }
}
