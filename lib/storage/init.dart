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

import 'package:kite_page/storage/dao/home.dart';
import 'package:kite_page/storage/storage/auth.dart';
import 'package:kite_page/storage/storage/home.dart';

import 'dao/index.dart';
import 'dao/report.dart';
import 'storage/theme.dart';

export 'dao/index.dart';

class KvStorageInitializer {
  static late ThemeSettingDao theme;
  static late AuthSettingDao auth;
  static late NetworkSettingDao network;
  static late JwtDao jwt;
  static late JwtDao sitAppJwt;
  static late LoginTimeDao loginTime;
  static late ReportStorageDao report;
  static late HomeSettingDao home;

  static void init() {
    theme = ThemeSettingStorage();
    home = HomeSettingStorage();
    auth = AuthSettingStorage();
  }
}
