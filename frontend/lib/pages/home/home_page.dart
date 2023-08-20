// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../cubits/course_preference_cubit/course_preference_cubit.dart';
import '../../cubits/jobs_cubit/jobs_cubit.dart';
import '../../models/job.dart';
import 'model/job_detail_argument.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const HomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppStrings.settings),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, AppStrings.webView,
                        arguments: "https://tp.bitmesra.co.in"),
                    child: const Text.rich(
                      TextSpan(
                        text: "BIT tnp\n",
                        children: [
                          TextSpan(
                            text: 'JOBS',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Your course'),
                      BlocBuilder<CoursePreferenceCubit, CoursePreferenceState>(
                        builder: (context, state) {
                          return Text(
                            state.currentCoursePreference.isEmpty
                                ? 'No course selected'
                                : abbreviationMap[
                                        state.currentCoursePreference] ??
                                    state.currentCoursePreference,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.right,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: JobListings(),
          ),
        ],
      ),
    );
  }
}

class JobListings extends StatelessWidget {
  const JobListings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursePreferenceCubit, CoursePreferenceState>(
      builder: (context, coursePreferenceState) =>
          BlocBuilder<JobsCubit, JobsState>(
        builder: (context, state) {
          if (state is JobsLoaded) {
            final List<Job> jobsList = state.newJobs;
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              padding: const EdgeInsets.all(16),
              itemCount: jobsList.length,
              itemBuilder: (context, index) {
                final Job currentItem = jobsList[index];
                final bool isEligible = currentItem.courses
                    .contains(coursePreferenceState.currentCoursePreference);
                final Color containerColor =
                    isEligible ? Colors.deepPurple : Colors.white;
                final Color textColor =
                    isEligible ? Colors.white : Colors.black;
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppStrings.jobDetails,
                    arguments: JobDetailArgument(
                      jobId: currentItem.id,
                      companyName: currentItem.company,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentItem.company,
                          style: TextStyle(
                            fontSize: 24,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text.rich(
                          TextSpan(
                            text: 'Posted on: ',
                            children: [
                              TextSpan(
                                text: currentItem.postedOn,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: textColor,
                                ),
                              ),
                            ],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _CustomText(
                          prefix: 'Deadline: ',
                          suffix: currentItem.deadLine,
                          textColor: textColor,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            if (currentItem.updates.isNotEmpty)
                              _UrlButton(
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  AppStrings.webView,
                                  arguments: baseUrl + currentItem.updates,
                                ),
                                textColor: textColor,
                                buttonText: 'check updates',
                              ),
                            if (currentItem.updates.isNotEmpty)
                              const SizedBox(width: 16),
                            if (currentItem.viewAndApply.isNotEmpty)
                              _UrlButton(
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  AppStrings.webView,
                                  arguments: baseUrl + currentItem.viewAndApply,
                                ),
                                textColor: textColor,
                                buttonText: 'view & apply',
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _UrlButton extends StatelessWidget {
  const _UrlButton({
    Key? key,
    this.onPressed,
    required this.textColor,
    required this.buttonText,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Color textColor;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        child: Text(
          buttonText,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: textColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _CustomText extends StatelessWidget {
  const _CustomText({
    required this.prefix,
    required this.suffix,
    required this.textColor,
  });

  final String prefix;
  final String suffix;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: prefix,
        children: [
          TextSpan(
            text: suffix,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: textColor,
            ),
          ),
        ],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      style: TextStyle(
        fontSize: 16,
        color: textColor,
      ),
    );
  }
}
