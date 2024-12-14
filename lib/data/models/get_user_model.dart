
import '../../core/api/end_ponits.dart';

class GetUserModel {
  final int id;
  final String username;
  final String password;
  final String first_name;
  final String last_name;
  final bool is_active;

  GetUserModel({
    required this.username,
    required this.password,
    required this.first_name,
    required this.last_name,
    required this.is_active,
    required this.id,
  });
  factory GetUserModel.fromJson(Map<String, dynamic> jsonData) {
    return GetUserModel(
        username: jsonData[ApiKey.name],
        password: jsonData[ApiKey.password],
        first_name: jsonData[ApiKey.firstname],
        last_name: jsonData[ApiKey.lastname],
        id: jsonData[ApiKey.id],
        is_active: jsonData[ApiKey.is_active]);
  }
}
//