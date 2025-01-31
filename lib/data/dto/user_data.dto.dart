import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataDto {
  String email;
  DateTime joinDate;
  DateTime lastLogin;
  String uid;
  int visitCount;

  UserDataDto({
    required this.email,
    required this.joinDate,
    required this.lastLogin,
    required this.uid,
    required this.visitCount,
  });

  UserDataDto.fromMap(Map<String, dynamic> map)
      : this(
          email: map['email'],
          joinDate: (map['joinDate'] as Timestamp).toDate(),
          lastLogin: (map['lastLogin'] as Timestamp).toDate(),
          uid: map['uid'],
          visitCount: map['visitCount'],
        );
}
