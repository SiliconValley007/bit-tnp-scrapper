import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/local_storage_manager.dart';

part 'course_preference_state.dart';

class CoursePreferenceCubit extends Cubit<CoursePreferenceState> {
  CoursePreferenceCubit()
      : super(const CoursePreferenceState(currentCoursePreference: '')) {
    updateCoursePreference();
  }

  late String _coursePreference = "";

  String get coursePreference => _coursePreference;

  void saveCoursePreference(String currentCoursePreference) async {
    await LocalStorage.saveCoursePreference(currentCoursePreference);
    _coursePreference = currentCoursePreference;
    emit(state.copyWith(currentCoursePreference: _coursePreference));
  }

  void deleteCoursePreference() async {
    await LocalStorage.deleteCoursePreference();
    _coursePreference = '';
    emit(state.copyWith(currentCoursePreference: _coursePreference));
  }

  void updateCoursePreference() {
    _coursePreference = LocalStorage.getCoursePreference() ?? '';
    emit(state.copyWith(currentCoursePreference: _coursePreference));
  }
}
