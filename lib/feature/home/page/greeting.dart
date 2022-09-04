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
import 'package:flutter_svg/svg.dart';
import 'package:kite_page/feature/kite/weather/entity.dart';
import 'package:kite_page/feature/web_page/weather.dart';
import 'package:kite_page/global/global.dart';
import 'package:kite_page/storage/init.dart';

/// 计算入学时间, 默认按 9 月 1 日开学来算. 年份 entranceYear 是完整的年份, 如 2018.
int _calcStudyDays(int entranceYear) {
  int days = DateTime.now().difference(DateTime(entranceYear, 9, 1)).inDays;
  return days;
}

class GreetingWidget extends StatefulWidget {
  const GreetingWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GreetingWidgetState();
}

class _GreetingWidgetState extends State<GreetingWidget> {
  int? studyDays;
  int campus = KvStorageInitializer.home.campus;
  Weather currentWeather = KvStorageInitializer.home.lastWeather;
  @override
  void initState() {
    super.initState();
    Global.eventBus.on(EventNameConstants.onWeatherUpdate, _onWeatherUpdate);
  }

  @override
  void deactivate() {
    super.deactivate();
    Global.eventBus.off(EventNameConstants.onWeatherUpdate, _onWeatherUpdate);
  }

  String _getCampusName() {
    if (campus == 1) return '奉贤校区';
    return '徐汇';
  }

  Widget _buildWeatherIcon(String iconCode) {
    return GestureDetector(
      onTap: () {
        final title = '${_getCampusName()}天气';
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => WeatherPage(campus, title: title)));
      },
      child: SvgPicture.asset('assets/weather/$iconCode.svg',
          width: 60, height: 60, fit: BoxFit.fill, color: Colors.white),
    );
  }

  void _onWeatherUpdate(dynamic newWeather) {
    KvStorageInitializer.home.lastWeather = newWeather;
    campus = KvStorageInitializer.home.campus;

    if (!mounted) return;
    setState(() => currentWeather = newWeather as Weather);
  }

  Widget buildAll(BuildContext context) {
    final textStyleSmall = Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white60, fontSize: 15.0);
    final textStyleLarge = Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white70, fontSize: 24.0);
    final textStyleWeather = Theme.of(context).textTheme.subtitle1?.copyWith(
          color: Colors.white70,
          fontSize: 19.0,
          fontWeight: FontWeight.w500,
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (studyDays != null // 天数为null说明不显示天数
                    ? <Widget>[
                        Text('今天是你在上应大的', style: textStyleSmall),
                        Text('第 $studyDays 天', style: textStyleLarge),
                      ]
                    : <Widget>[Text('欢迎使用上应小风筝', style: textStyleSmall)]) +
                <Widget>[
                  Text('${_getCampusName()} ${currentWeather.weather} ${currentWeather.temperature} °C',
                      style: textStyleWeather)
                ],
          ),
        ),
        SizedBox(child: _buildWeatherIcon(currentWeather.icon)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: buildAll(context),
    );
  }
}
