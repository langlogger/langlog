import 'package:langlog/data/dto/user_data.dto.dart';

class UserData {
  String email;
  DateTime joinDate;
  DateTime lastLogin;
  String uid;
  int visitCount;

  UserData({
    required this.email,
    required this.joinDate,
    required this.lastLogin,
    required this.uid,
    required this.visitCount,
  });

  factory UserData.fromDto(UserDataDto dto) {
    return UserData(
      email: dto.email,
      joinDate: dto.joinDate,
      lastLogin: dto.lastLogin,
      uid: dto.uid,
      visitCount: dto.visitCount,
    );
  }
}
