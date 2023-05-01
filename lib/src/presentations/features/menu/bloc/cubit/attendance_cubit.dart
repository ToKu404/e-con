import 'package:bloc/bloc.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:e_con/src/domain/usecases/attendance_usecases/get_list_attendance.dart';
import 'package:equatable/equatable.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final GetListAttendance getListAttendanceUsecase;

  AttendanceCubit({required this.getListAttendanceUsecase})
      : super(AttendanceInitial());

  Future<void> onFetchAttendance({
    required int meetingId,
    String? query,
  }) async {
    emit(AttendanceLoading());
    try {
      final data = await getListAttendanceUsecase.execute(
          meetingId: meetingId, query: query);
      data.fold((l) => emit(FetchAttendanceFailure(message: l.message)),
          (r) => emit(FetchAttendanceSuccess(attendanceData: r ?? [])));
    } catch (e) {
      emit(FetchAttendanceFailure(message: e.toString()));
    }
  }
}
