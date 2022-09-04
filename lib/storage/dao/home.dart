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
import 'package:kite_page/feature/home/entity/home.dart';
import 'package:kite_page/feature/kite/weather/entity.dart';

abstract class HomeSettingDao {
  int get campus; // 校区

  String? get background; // 背景图片 path

  set background(String? path);

  int get backgroundMode; // 背景模式

  set backgroundMode(int mode);

  DateTime? get installTime; // 安装时间

  set installTime(DateTime? dateTime);

  Weather get lastWeather; // 天气

  set lastWeather(Weather weather);

  String? get lastHotSearch;

  set lastHotSearch(String? hotSearch);

  String? get lastOfficeStatus;

  set lastOfficeStatus(String? status);

  Set<int>? get readNotice;

  set readNotice(Set<int>? noticeSet);

  List<FunctionType>? get homeItems;

  set homeItems(List<FunctionType>? newButtonList);
}
