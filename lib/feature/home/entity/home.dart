/*
 * 上应小风筝  便利校园，一步到位
 * Copyright (C) 2022 上海应用技术大学 上应小风筝团队
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'dart:collection';

import 'package:kite_page/util/user.dart';

enum FunctionType {
  /// 升级
  upgrade,

  /// 公告
  notice,

  /// 课程表
  timetable,

  /// 体温上报
  report,

  /// 考试安排
  exam,

  /// 空教室
  classroom,

  /// 活动
  event,

  /// 消费查询
  expense,

  /// 成绩查询
  score,

  /// 图书馆

  library,

  /// 办公
  office,

  /// Edu 邮箱
  mail,

  /// OA 公告
  bulletin,

  /// 常用电话
  contact,

  /// 小游戏
  game,

  /// wiki
  wiki,

  /// 分隔符
  separator,

  /// 上应互助
  bbs,

  /// 扫码
  scanner,

  /// 迎新(入学信息)
  freshman,

  /// 切换账户
  switchAccount,

  /// 风筝时刻
  board,
}

/// 用户的功能列表
abstract class IUserFunctionList {
  List<FunctionType> getFunctionList();
}

/// 本、专科生默认功能列表
class UndergraduateFunctionList implements IUserFunctionList {
  @override
  List<FunctionType> getFunctionList() {
    return <FunctionType>[
      FunctionType.upgrade,
      FunctionType.notice,
      FunctionType.timetable,
      FunctionType.report,
      FunctionType.separator,
      FunctionType.exam,
      FunctionType.classroom,
      FunctionType.event,
      FunctionType.expense,
      FunctionType.score,
      FunctionType.library,
      FunctionType.office,
      FunctionType.mail,
      FunctionType.bulletin,
      FunctionType.separator,
      FunctionType.freshman,
      FunctionType.scanner,
      FunctionType.bbs,
      FunctionType.contact,
      FunctionType.game,
      FunctionType.board,
      FunctionType.wiki,
      FunctionType.separator,
    ];
  }
}

/// 研究生默认功能列表
class PostgraduateFunctionList implements IUserFunctionList {
  @override
  List<FunctionType> getFunctionList() {
    return <FunctionType>[
      FunctionType.upgrade,
      FunctionType.notice,
      FunctionType.report,
      FunctionType.separator,
      FunctionType.classroom,
      FunctionType.expense,
      FunctionType.library,
      FunctionType.office,
      FunctionType.mail,
      FunctionType.bulletin,
      FunctionType.separator,
      FunctionType.freshman,
      FunctionType.scanner,
      FunctionType.bbs,
      FunctionType.contact,
      FunctionType.game,
      FunctionType.board,
      FunctionType.wiki,
      FunctionType.separator,
    ];
  }
}

/// 教师账户默认功能列表
class TeacherFunctionList implements IUserFunctionList {
  @override
  List<FunctionType> getFunctionList() {
    return <FunctionType>[
      FunctionType.upgrade,
      FunctionType.notice,
      FunctionType.report,
      FunctionType.separator,
      FunctionType.expense,
      FunctionType.library,
      FunctionType.office,
      FunctionType.mail,
      FunctionType.bulletin,
      FunctionType.separator,
      FunctionType.scanner,
      FunctionType.bbs,
      FunctionType.contact,
      FunctionType.game,
      FunctionType.board,
      FunctionType.wiki,
      FunctionType.separator,
    ];
  }
}

/// 新生功能列表
class FreshmanFunctionList implements IUserFunctionList {
  @override
  List<FunctionType> getFunctionList() {
    return <FunctionType>[
      FunctionType.upgrade,
      FunctionType.notice,
      FunctionType.switchAccount,
      FunctionType.separator,
      FunctionType.freshman,
      FunctionType.scanner,
      FunctionType.bbs,
      FunctionType.contact,
      FunctionType.board,
      FunctionType.wiki,
      FunctionType.separator,
    ];
  }
}

class UserFunctionListFactory {
  static final _cache = HashMap<UserType, IUserFunctionList>();

  static IUserFunctionList getUserFunctionList(UserType userType) {
    if (_cache.containsKey(userType)) {
      return _cache[userType]!;
    }
    _cache[userType] = {
      UserType.undergraduate: () => UndergraduateFunctionList(),
      UserType.postgraduate: () => PostgraduateFunctionList(),
      UserType.teacher: () => TeacherFunctionList(),
      UserType.freshman: () => FreshmanFunctionList(),
    }[userType]!();

    return _cache[userType]!;
  }
}

List<FunctionType> getDefaultFunctionList(UserType userType) {
  return UserFunctionListFactory.getUserFunctionList(userType).getFunctionList();
}
