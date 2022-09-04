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
import 'package:kite_page/global/global.dart';
import 'package:kite_page/route.dart';
import 'package:kite_page/storage/init.dart';
import 'package:kite_page/util/logger.dart';
import 'package:kite_page/util/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universal_platform/universal_platform.dart';

import '../entity/home.dart';
import 'background.dart';
import 'drawer.dart';
import 'greeting.dart';
import 'group.dart';
import 'item/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  late bool isFreshman;

  void _updateWeather() {
    Log.info('更新天气');
    // Future.delayed(const Duration(milliseconds: 800), () async {
    //   try {
    //     final weather = await WeatherService().getCurrentWeather(KvStorageInitializer.home.campus);
    //     Global.eventBus.emit(EventNameConstants.onWeatherUpdate, weather);
    //   } catch (_) {
    //     Global.eventBus.emit(EventNameConstants.onWeatherUpdate, Weather.defaultWeather());
    //   }
    // });
  }

  Future<void> _onHomeRefresh(BuildContext context) async {
    // 优化用户体验
    await Future.delayed(const Duration(seconds: 1));
    _refreshController.refreshCompleted(resetFooterState: true);
    _updateWeather();
  }

  Widget _buildTitleLine(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => _scaffoldKey.currentState?.openDrawer(),
        onDoubleTap: () => Navigator.of(context).pushNamed(RouteTable.egg),
        child: Center(child: SvgPicture.asset('assets/home/kite.svg', width: 80.w, height: 80.h)),
      ),
    );
  }

  List<Widget> buildFunctionWidgets() {
    List<FunctionType> list = KvStorageInitializer.home.homeItems ?? getDefaultFunctionList();

    // 先遍历一遍，过滤相邻重复元素
    FunctionType lastItem = list.first;
    for (int i = 1; i < list.length; ++i) {
      if (lastItem == list[i]) {
        list.removeAt(i);
        i -= 1;
      } else {
        lastItem = list[i];
      }
    }

    final separator = SizedBox(height: 20.h);
    final List<Widget> result = [];
    List<Widget> currentGroup = [];

    for (final item in list) {
      if (item == FunctionType.separator) {
        result.addAll([HomeItemGroup(currentGroup), separator]);
        currentGroup = [];
      } else {
        currentGroup.add(FunctionButtonFactory.createFunctionButton(item));
      }
    }
    return [
      const GreetingWidget(),
      separator,
      ...result,
      separator,
      Image.asset('assets/home/bottom.png'),
    ];
  }

  Widget _buildBody(BuildContext context) {
    final items = buildFunctionWidgets();

    return Stack(
      children: [
        const HomeBackground(),
        SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: _refreshController,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  title: _buildTitleLine(context),
                ),
                expandedHeight: 0.6.sh,
                backgroundColor: Colors.transparent,
                centerTitle: false,
                elevation: 0,
                pinned: false,
              ),
              SliverList(
                // Functions
                delegate: SliverChildBuilderDelegate(
                  (_, index) => Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: items[index],
                  ),
                  childCount: items.length,
                ),
              ),
            ],
          ),
          onRefresh: () => _onHomeRefresh(context),
        ),
      ],
    );
  }

  @override
  void initState() {
    isFreshman = AccountUtils.getUserType() == UserType.freshman;
    Log.info('开始加载首页');

    _onHomeRefresh(context);

    Global.eventBus.on(EventNameConstants.onCampusChange, (_) => _updateWeather());
    Global.eventBus.on(EventNameConstants.onHomeItemReorder, (_) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    Global.eventBus.off(EventNameConstants.onCampusChange);
    Global.eventBus.off(EventNameConstants.onHomeItemReorder);
    super.dispose();
  }

  Widget? buildFloatingActionButton() {
    return UniversalPlatform.isDesktopOrWeb
        ? FloatingActionButton(
            child: const Icon(Icons.refresh),
            onPressed: () async {
              // 刷新页面
              Log.info('浮动按钮被点击');
              // 触发下拉刷新
              final pos = _refreshController.position!;
              await pos.animateTo(-100, duration: const Duration(milliseconds: 800), curve: Curves.linear);
            },
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    Log.info('Build Home');
    return Scaffold(
      key: _scaffoldKey,
      body: _buildBody(context),
      drawer: const KiteDrawer(),
      floatingActionButton: buildFloatingActionButton(),
    );
  }
}
