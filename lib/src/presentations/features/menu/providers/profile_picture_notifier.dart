import 'dart:typed_data';

import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/domain/usecases/profile_usecases/get_profile_picture.dart';
import 'package:flutter/widgets.dart';

class ProfilePictureNotifier extends ChangeNotifier {
  final GetProfilePicture getProfilePictureUsecase;

  ProfilePictureNotifier({
    required this.getProfilePictureUsecase,
  });

  Uint8List? _profilePicture;
  Uint8List? get profilePicture => _profilePicture;
  RequestState _state = RequestState.init;
  RequestState get state => _state;

  Future<void> getProfilePicture() async {
    _state = RequestState.loading;
    notifyListeners();
    final result = await getProfilePictureUsecase.execute();

    result.fold((l) {
      _state = RequestState.error;
    }, (r) {
      _profilePicture = r;
      _state = RequestState.success;
    });
    notifyListeners();
  }
}
