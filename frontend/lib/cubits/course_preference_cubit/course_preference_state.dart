// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'course_preference_cubit.dart';

class CoursePreferenceState extends Equatable {
  const CoursePreferenceState({required this.currentCoursePreference});

  final String currentCoursePreference;

  @override
  List<Object> get props => [currentCoursePreference];

  CoursePreferenceState copyWith({
    String? currentCoursePreference,
  }) {
    return CoursePreferenceState(
      currentCoursePreference: currentCoursePreference ?? this.currentCoursePreference,
    );
  }
}
