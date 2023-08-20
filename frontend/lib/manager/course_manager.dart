abstract class CourseManager {
  static final Set<String> _courses = <String>{};
  static List<String> _coursesList = ['MCA'];

  static void addUniqueString(Set<String> newStrings) {
    _courses.addAll(newStrings);
  }

  static void finalizeList() {
    _coursesList = _courses.toList();
    _coursesList.sort();
  }

  static List<String> get coursesList => _coursesList;
}
