import 'package:kite_page/storage/init.dart';

enum UserType {
  /// 本、专科生（10位学号）
  undergraduate,

  /// 研究生（9位学号）
  postgraduate,

  /// 教师（4位工号）
  teacher,

  /// 未入学的新生
  freshman,
}

class AccountUtils {
  static UserType? getUserType() {
    return KvStorageInitializer.auth.userType;
  }
}
