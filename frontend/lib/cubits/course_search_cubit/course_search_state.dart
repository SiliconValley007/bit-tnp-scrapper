part of 'course_search_cubit.dart';

sealed class CourseSearchState extends Equatable {
  const CourseSearchState();

  @override
  List<Object> get props => [];
}

final class Searching extends CourseSearchState {}

final class SearchResults extends CourseSearchState {
  final List<String> results;

  const SearchResults({
    required this.results,
  });
}
