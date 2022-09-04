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
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kite_page/storage/init.dart';
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
    // 设置 HTTP 代理
    HttpOverrides.global = KiteHttpOverrides(config: config);

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

class KiteHttpOverrides extends HttpOverrides {
  final DioConfig config;
  KiteHttpOverrides({required this.config});

  String getProxyPolicyByUrl(Uri url, String httpProxy) {
    Log.info('直连访问 $url');
    return 'DIRECT';
  }

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);

    // 设置证书检查
    if (config.allowBadCertificate || KvStorageInitializer.network.useProxy || config.httpProxy != null) {
      client.badCertificateCallback = (cert, host, port) => true;
    }

    // 设置代理. 优先使用代码中的设置, 便于调试.
    if (config.httpProxy != null) {
      // 判断测试环境代理合法性
      // TODO: 检查代理格式
      if (config.httpProxy!.isNotEmpty) {
        // 可以
        Log.info('测试环境设置代理: ${config.httpProxy}');
        client.findProxy = (url) => getProxyPolicyByUrl(url, config.httpProxy!);
      } else {
        // 不行
        Log.info('测试环境代理服务器为空或不合法，将不使用代理服务器');
      }
    } else if (KvStorageInitializer.network.useProxy && KvStorageInitializer.network.proxy.isNotEmpty) {
      Log.info('线上设置代理: ${config.httpProxy}');
      client.findProxy = (url) => getProxyPolicyByUrl(url, KvStorageInitializer.network.proxy);
    }
    return client;
  }
}
