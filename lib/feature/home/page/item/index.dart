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
import 'package:kite_page/feature/home/entity/home.dart';
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
  static final builders = {
    FunctionType.notice: () => HomeFunctionButton(
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
  };
  static Widget createFunctionButton(FunctionType type) {
    final btnBuilder = builders[type];
    return btnBuilder == null ? Container() : btnBuilder();
  }
}
