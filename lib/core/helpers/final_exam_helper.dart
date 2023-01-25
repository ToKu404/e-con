import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/src/data/models/final_exam/fe_proposed_thesis.dart';
import 'package:flutter/widgets.dart';

final listFeObject = [];

class FinalExamHelper {
  static String titleMaker(String title) {
    final listTitle = title.split(' ');
    String newTitle = '';
    for (var t in listTitle) {
      newTitle += t[0].toUpperCase() + t.substring(1, t.length) + " ";
    }
    return newTitle.trim();
  }

  static void getHomeFinalExamData(
      {required List<FeProposedThesis> listProposedThesis,
      required BuildContext context}) {
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
          ),
        );
      }
      if (listProposedThesis[i].proposalStatus == 'Diterima') {
        listFeObject.clear();
        String status = '';
        if (listProposedThesis[i].skStatus == null) {
          status = 'Menunggu SK Pembimbing dan Penguji';
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
        ));
        return;
      }
    }
  }
}

class FinalExamObject {
  final String title;
  final String? message;
  final String status;
  final VoidCallback? onclick;

  FinalExamObject(
      {required this.title, this.message, required this.status, this.onclick});
}

Map<String, String> feStatus = {
  'Sedang_Diproses': 'Sedang Diproses',
  'Diterima': 'Diterima',
  'Ditolak': 'Ditolak',
};
