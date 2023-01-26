import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/profile/notification.dart';
import 'package:e_con/src/domain/repositories/profile_repository.dart';

class GetNotifications {
  final ProfileRepository profileRepository;

  GetNotifications({required this.profileRepository});

  Future<Either<Failure, List<NotificationModel>>> execute() async {
    return profileRepository.getNotification();
  }
}
