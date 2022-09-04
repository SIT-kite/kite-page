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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kite_page/app.dart';
import 'package:kite_page/feature/home/entity/home.dart';
import 'package:kite_page/feature/home/page/item/notice.dart';
import 'package:kite_page/route.dart';

class HomeFunctionButton extends StatelessWidget {
  final String? route;
  final String? icon;
  final Widget? iconWidget;
  final String title;
  final String? subtitle;
  final VoidCallback? onPressed;
  HomeFunctionButton({
    this.route,
    this.onPressed,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconWidget,
    Key? key,
  }) : super(key: key) {
    assert(icon != null || iconWidget != null);
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headline4?.copyWith(color: Colors.black54);
    final subtitleStyle = Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black54);

    return Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.6)),
      child: ListTile(
        leading:
            iconWidget ?? SvgPicture.asset(icon!, height: 30.h, width: 30.w, color: Theme.of(context).primaryColor),
        title: Text(title, style: titleStyle),
        subtitle: Text(subtitle ?? '', style: subtitleStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
        // dense: true,
        onTap: () {
          if (onPressed != null) {
            onPressed!();
            return;
          }
          if (route != null) {
            Navigator.of(context).pushNamed(route!);
          }
        },
        style: ListTileStyle.list,
      ),
    );
  }
}

class FunctionButtonFactory {
  static get context => KiteApp.navigatorKey.currentContext!;
  static final builders = {
    FunctionType.download: () => HomeFunctionButton(
          route: RouteTable.download,
          iconWidget: Icon(Icons.download, size: 30.h, color: Theme.of(context).primaryColor),
          title: '下载',
          subtitle: '立即下载最新版小风筝',
        ),
    FunctionType.bulletin: () => HomeFunctionButton(
          route: RouteTable.notice,
          icon: 'assets/home/icon_bulletin.svg',
          title: 'OA公告',
          subtitle: '查看学校通知',
        ),
    FunctionType.mail: () => HomeFunctionButton(
          route: '/mail',
          icon: 'assets/home/icon_mail.svg',
          title: 'Edu 邮箱',
          subtitle: '查看校园邮箱中的邮件',
        ),
    FunctionType.office: () => HomeFunctionButton(
          route: '/office',
          icon: 'assets/home/icon_office.svg',
          title: '办公',
          subtitle: '通过应网办办理业务',
        ),
    FunctionType.library: () => HomeFunctionButton(
          route: '/library',
          icon: 'assets/home/icon_library.svg',
          title: '图书馆',
          subtitle: '热搜: 《Flutter实战》',
        ),
    FunctionType.score: () => HomeFunctionButton(
          route: '/score',
          icon: 'assets/home/icon_score.svg',
          title: '成绩',
          subtitle: '愿每一天都有收获',
        ),
    FunctionType.expense: () => HomeFunctionButton(
          route: '/expense',
          icon: 'assets/home/icon_expense.svg',
          title: '查消费',
          subtitle: '近期消费10元 一食堂',
        ),
    FunctionType.event: () => HomeFunctionButton(
          route: '/event',
          icon: 'assets/home/icon_event.svg',
          title: '活动',
          subtitle: '查看最新的第二课堂活动',
        ),
    FunctionType.classroom: () => HomeFunctionButton(
          route: RouteTable.classroom,
          icon: 'assets/home/icon_classroom.svg',
          title: '空教室',
          subtitle: '查看当前无课的教室',
        ),
    FunctionType.exam: () => HomeFunctionButton(
          route: RouteTable.exam,
          icon: 'assets/home/icon_exam.svg',
          title: '考试安排',
          subtitle: '近期无考试',
        ),
    FunctionType.report: () => HomeFunctionButton(
          route: RouteTable.report,
          icon: 'assets/home/icon_report.svg',
          title: '体温上报',
          subtitle: '今日已上报',
        ),
    FunctionType.timetable: () => HomeFunctionButton(
          route: RouteTable.timetable,
          icon: 'assets/home/icon_timetable.svg',
          title: '课程表',
          subtitle: '查看近期课程',
        ),
    FunctionType.notice: () => const NoticeItem(),
    FunctionType.scanner: () => HomeFunctionButton(
          onPressed: () {},
          iconWidget: Icon(Icons.qr_code_scanner, size: 30.h, color: Theme.of(context).primaryColor),
          title: '扫码',
          subtitle: '扫描各种二维码',
        ),
    FunctionType.bbs: () => HomeFunctionButton(
          route: RouteTable.bbs,
          icon: 'assets/home/icon_bbs.svg',
          title: '问答',
          subtitle: '这里有我们共同的声音',
        ),
    FunctionType.board: () => HomeFunctionButton(
          route: RouteTable.board,
          icon: 'assets/home/icon_board.svg',
          title: '风筝时刻',
          subtitle: '随手记录美好',
        ),
    FunctionType.contact: () => HomeFunctionButton(
          route: RouteTable.contact,
          icon: 'assets/home/icon_contact.svg',
          title: '常用电话',
          subtitle: '查找学校部门的联系方式',
        ),
    FunctionType.game: () => HomeFunctionButton(
          route: RouteTable.game,
          icon: 'assets/home/icon_game.svg',
          title: '小游戏',
          subtitle: '来放松一下吧',
        ),
    FunctionType.wiki: () => HomeFunctionButton(
          route: RouteTable.wiki,
          icon: 'assets/home/icon_wiki.svg',
          title: 'Wiki',
          subtitle: '上应大生存指南',
        ),
  };
  static Widget createFunctionButton(FunctionType type) {
    final btnBuilder = builders[type];
    return btnBuilder == null ? Container() : btnBuilder();
  }
}
