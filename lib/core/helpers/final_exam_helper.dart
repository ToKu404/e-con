import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/src/data/models/final_exam/fe_proposed_thesis.dart';
import 'package:e_con/src/data/models/final_exam/fe_seminar.dart';
import 'package:flutter/widgets.dart';

class FinalExamHelper {
  static String titleMaker(String title) {
    final listTitle = title.split(' ');
    String newTitle = '';
    for (var t in listTitle) {
      newTitle += t[0].toUpperCase() + t.substring(1, t.length) + " ";
    }
    return newTitle.trim();
  }

  static List<FinalExamObject> getHomeFinalExamData(
      {required List<FeProposedThesis> listProposedThesis,
      required List<FeSeminar> listSeminar,
      required BuildContext context}) {
    final List<FinalExamObject> listFeObject = [];
    if (listSeminar.isNotEmpty) {
      String message =
          "\"${titleMaker(listSeminar.first.finalExamData!.title!)}\"";
      String title = '';
      final activeSeminar = listSeminar[listSeminar.length - 1];

      title = seminarType[activeSeminar.examType!]!;
      String status = '';
      Color color = Palette.secondary;
      if (activeSeminar.invitationFiles == null || activeSeminar.date == null) {
        status = 'Pengajuan sedang diproses';
      } else {
        if (DateTime.now().isBefore(activeSeminar.date!)) {
          status = 'Menunggu Jadwal ${titleMaker(title)}';
        } else {
          status = 'Selesai Ujian ${titleMaker(title)}';
          color = Palette.success;
        }
      }
      listFeObject.add(FinalExamObject(
        title: title,
        status: status,
        color: color,
        message: message,
        onclick: () {
          Navigator.pushNamed(context, AppRoutes.lecturerDetailSeminar,
              arguments: activeSeminar.seminarId);
        },
      ));
      print(listFeObject.first.title);
      print(listFeObject.first.status);
      print(listFeObject.first.color);
      print(listFeObject.first.message);
    } else {
      // Saat kedunya masih diproses
      for (int i = 0; i < listProposedThesis.length; i++) {
        if (listProposedThesis[i].proposalStatus == 'Sedang_Diproses' ||
            listProposedThesis[i].proposalStatus == 'Ditolak') {
          listFeObject.add(
            FinalExamObject(
              title: 'Usulan #${i + 1}',
              message: titleMaker(listProposedThesis[i].title ?? ''),
              status: '${feStatus[listProposedThesis[i].proposalStatus!]}',
              onclick: () {},
              color: listProposedThesis[i].proposalStatus == 'Ditolak'
                  ? Palette.danger
                  : Palette.secondary,
            ),
          );
        }
        if (listProposedThesis[i].proposalStatus == 'Diterima') {
          listFeObject.clear();
          String status = '';
          Color color = Palette.success;
          if (listProposedThesis[i].skStatus == null) {
            status = 'Menunggu SK Pembimbing dan Penguji';
            color = Palette.secondary;
          } else {
            status = 'Pengajuan Diterima';
          }
          listFeObject.add(FinalExamObject(
            title: 'Usulan #${i + 1}',
            message: titleMaker(listProposedThesis[i].title ?? ''),
            status: status,
            onclick: () {
              Navigator.pushNamed(context, AppRoutes.lecturerDetailSeminar,
                  arguments: listProposedThesis[i].id);
            },
            color: color,
          ));
          return listFeObject;
        }
      }
    }
    return listFeObject;
  }
}

class FinalExamObject {
  final String title;
  final String? message;
  final String status;
  final Color color;
  final VoidCallback? onclick;

  FinalExamObject(
      {required this.title,
      this.message,
      required this.status,
      this.onclick,
      required this.color});
}

final Map<String, String> seminarType = {
  'Seminar_Proposal': 'Seminar Proposal',
  'Seminar_Hasil': 'Seminar Hasil',
  'Ujian_Skripsi': 'Ujian Skripsi',
};

Map<String, String> feStatus = {
  'Sedang_Diproses': 'Sedang Diproses',
  'Diterima': 'Diterima',
  'Ditolak': 'Ditolak',
};
