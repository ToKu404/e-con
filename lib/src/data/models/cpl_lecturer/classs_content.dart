import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:equatable/equatable.dart';

class ClazzContent extends Equatable {
  ClazzContent({
    this.listClazz,
  });

  final List<ClazzData>? listClazz;

  factory ClazzContent.fromJson(Map<String, dynamic> json) {
    Iterable data = json['content'] as List;
    return ClazzContent(
      listClazz: List<ClazzData>.from(
        data.map(
          (e) => ClazzData.fromJson(e),
        ),
      ),
    );
  }

  @override
  List<Object?> get props => [listClazz];
}
