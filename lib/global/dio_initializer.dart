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
import 'package:dio/dio.dart';
import 'package:kite_page/util/logger.dart';

const String _defaultUaString = 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:46.0) Gecko/20100101 Firefox/46.0';

class DioConfig {
  String? httpProxy;
  bool allowBadCertificate = true;
  int? connectTimeout;
  int? sendTimeout;
  int? receiveTimeout;
}

/// 用于初始化Dio,全局只有一份dio对象
class DioInitializer {
  /// 初始化SessionPool
  static Future<Dio> init({required DioConfig config}) async {
    Log.info('初始化Dio');
    // dio初始化完成后，才能初始化 UA
    final dio = _initDioInstance(config: config);
    return dio;
  }

  static Dio _initDioInstance({required DioConfig config}) {
    Dio dio = Dio();

    // 设置默认超时时间
    dio.options = dio.options.copyWith(
      connectTimeout: config.connectTimeout,
      sendTimeout: config.sendTimeout,
      receiveTimeout: config.receiveTimeout,
    );
    return dio;
  }
}
