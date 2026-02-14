import 'exerciseModel.dart';
import 'userModel.dart';
import 'openingScheduleModel.dart';
import 'userMeasurementModel.dart';

class UserScheduling {
  final int id;
  final Exercise exercise;
  final User user;
  final OpeningSchedule openingSchedule;
  final UserMeasurement userMeasurement;

  UserScheduling({
    required this.id,
    required this.exercise,
    required this.user,
    required this.openingSchedule,
    required this.userMeasurement,
  });

  factory UserScheduling.fromJson(Map<String, dynamic> json) =>
      UserScheduling(
        id: json['id'],
        exercise: Exercise.fromJson(json['exercise']),
        user: User.fromJson(json['user']),
        openingSchedule:
            OpeningSchedule.fromJson(json['opening_schedule']),
        userMeasurement:
            UserMeasurement.fromJson(json['user_measurement']),
      );
}
