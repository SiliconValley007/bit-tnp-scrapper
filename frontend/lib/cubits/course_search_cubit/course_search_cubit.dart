import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/course_manager.dart';

part 'course_search_state.dart';

class CourseSearchCubit extends Cubit<CourseSearchState> {
  CourseSearchCubit()
      : super(SearchResults(results: CourseManager.coursesList));

  void searchCourses({String keyword = ''}) {
    if (keyword.isEmpty) {
      emit(SearchResults(results: CourseManager.coursesList));
      return;
    }
    emit(Searching());
    List<String> filteredCourses = [];
    for (int i = 0; i < CourseManager.coursesList.length; i++) {
      final String current = CourseManager.coursesList[i];
      if (current.contains(keyword)) {
        filteredCourses.add(current);
      }
    }
    emit(SearchResults(results: filteredCourses));
  }
}
