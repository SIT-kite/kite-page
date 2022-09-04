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
import 'package:flutter/material.dart';
import 'package:kite_page/feature/kite/init.dart';
import 'package:kite_page/feature/kite/notice/entity.dart';
import 'package:kite_page/global/global.dart';
import 'package:kite_page/route.dart';

import 'index.dart';

class NoticeItem extends StatefulWidget {
  const NoticeItem({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoticeItemState();
}

class _NoticeItemState extends State<NoticeItem> {
  static const defaultContent = '查看小风筝的公告';
  String content = '加载中';

  @override
  void initState() {
    Global.eventBus.on(EventNameConstants.onHomeRefresh, _onHomeRefresh);
    super.initState();
  }

  @override
  void dispose() {
    Global.eventBus.off(EventNameConstants.onHomeRefresh, _onHomeRefresh);
    super.dispose();
  }

  void _onHomeRefresh(_) async {
    final String result = await _buildContent() ?? defaultContent;
    if (!mounted) return;
    setState(() => content = result);
  }

  Future<String?> _buildContent() async {
    try {
      final List<KiteNotice> list = await KiteInitializer.noticeService.getNoticeList();
      return list.first.title;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _buildContent(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          content = snapshot.data ?? defaultContent;
        }
        return HomeFunctionButton(
          route: RouteTable.notice,
          icon: 'assets/home/icon_notice.svg',
          title: '公告',
          subtitle: content,
        );
      },
    );
  }
}
