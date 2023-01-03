import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:spiccato/pages/main_page/main_page.dart';
import 'package:spiccato/utils/theme.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    const initialSize = Size(800, 650);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'Spiccato';
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spiccato',
      theme: AppThemes.light,
      home: MainPage(),
    );
  }
}
