import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_list_course.dart';
import 'package:flutter/material.dart';

class LectureCourseNotifier extends ChangeNotifier {
  final GetListCourse getListCourseUsecase;

  LectureCourseNotifier({
    required this.getListCourseUsecase,
  }) {
    getListCourses();
  }

  String _error = '';
  String get error => _error;

  RequestState _state = RequestState.init;
  RequestState get state => _state;

  List<ClazzData>? _listCourse;
  List<ClazzData>? get listClazz => _listCourse;

  Future<void> getListCourses() async {
    _state = RequestState.loading;
    notifyListeners();
    final result = await getListCourseUsecase.execute();

    result.fold((l) {
      _error = l.message;
      _state = RequestState.error;
    }, (r) {
      _listCourse = r;
      _state = RequestState.success;
    });
    notifyListeners();
  }
}
