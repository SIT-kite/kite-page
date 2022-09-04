import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('找不到页面'),
      ),
      body: const Center(
        child: Text('404 Not Found'),
      ),
    );
  }
}
