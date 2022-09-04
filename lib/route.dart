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
import 'package:kite_page/feature/not_found/page.dart';
import 'package:kite_page/feature/web_page/about.dart';
import 'package:kite_page/feature/web_page/feedback.dart';

import 'feature/egg/page/index.dart';
import 'feature/home/page/index.dart';
import 'feature/kite/notice/page.dart';

typedef NamedRouteBuilder = Widget Function(BuildContext context, Map<String, dynamic> args);

class RouteTable {
  static const home = '/home';
  static const report = '/report';
  static const login = '/login';
  static const welcome = '/welcome';
  static const about = '/about';
  static const expense = '/expense';
  static const connectivity = '/connectivity';
  static const campusCard = '/campusCard';
  static const electricity = '/electricity';
  static const score = '/score';
  static const office = '/office';
  static const game = '/game';
  static const game2048 = '$game/2048';
  static const gameWordle = '$game/wordle';
  static const gameComposeSit = '$game/composeSit';
  static const gameTetris = '$game/tetris';
  static const wiki = '/wiki';
  static const library = '/library';
  static const libraryAppointment = '$library/appointment';
  static const market = '/market';
  static const timetable = '/timetable';
  static const timetableImport = '$timetable/import';
  static const setting = '/setting';
  static const feedback = '/feedback';
  static const notice = '/notice';
  static const contact = '/contact';
  static const bulletin = '/bulletin';
  static const mail = '/mail';
  static const night = '/night';
  static const event = '/event';
  static const lostFound = '/lostFound';
  static const classroom = '/classroom';
  static const exam = '/exam';
  static const egg = '/egg';
  static const bbs = '/bbs';
  static const scanner = '/scanner';
  static const browser = '/browser';
  static const freshman = '/freshman';
  static const freshmanLogin = '$freshman/login';
  static const freshmanUpdate = '$freshman/update';
  static const freshmanAnalysis = '$freshman/analysis';
  static const freshmanFriend = '$freshman/friend';
  static const board = '/board';
  static const notFound = '/notFound';

  static final Map<String, NamedRouteBuilder> routeTable = {
    home: (context, args) => const HomePage(),
    egg: (context, args) => const EggPage(),
    notice: (context, args) => const NoticePage(),
    notFound: (context, args) => const NotFoundPage(),
    about: (context, args) => const AboutPage(),
    feedback: (context, args) => const FeedbackPage(),
  };

  static NamedRouteBuilder get(String path) {
    return routeTable[path] ?? routeTable[notFound]!;
  }
}
