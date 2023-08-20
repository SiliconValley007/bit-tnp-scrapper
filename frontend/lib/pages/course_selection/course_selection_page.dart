import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnp_scanner/cubits/course_preference_cubit/course_preference_cubit.dart';

import '../../cubits/course_search_cubit/course_search_cubit.dart';

class CourseSelectionPage extends StatelessWidget {
  const CourseSelectionPage({super.key});

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const CourseSelectionPage());

  @override
  Widget build(BuildContext context) {
    final CoursePreferenceCubit coursePreferenceCubit =
        context.read<CoursePreferenceCubit>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 30),
              const Text(
                'Your course',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              BlocBuilder<CoursePreferenceCubit, CoursePreferenceState>(
                builder: (context, state) {
                  return Text(
                    state.currentCoursePreference.isEmpty
                        ? 'No course selected'
                        : state.currentCoursePreference,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<CoursePreferenceCubit, CoursePreferenceState>(
                builder: (context, coursePreferenceState) {
                  return BlocBuilder<CourseSearchCubit, CourseSearchState>(
                    builder: (context, state) {
                      if (state is SearchResults) {
                        return Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final String current = state.results[index];
                              final bool isCurrentSame = current ==
                                  coursePreferenceState.currentCoursePreference;
                              return GestureDetector(
                                onTap: () {
                                  if (!isCurrentSame) {
                                    coursePreferenceCubit
                                        .saveCoursePreference(current);
                                  } else {
                                    if (coursePreferenceState
                                        .currentCoursePreference.isNotEmpty) {
                                      coursePreferenceCubit
                                          .deleteCoursePreference();
                                    }
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    border: isCurrentSame
                                        ? Border.all(color: Colors.green)
                                        : Border.all(color: Colors.white),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Text(current),
                                ),
                              );
                            },
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 16),
                            itemCount: state.results.length,
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
