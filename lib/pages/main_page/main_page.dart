import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:spiccato/pages/favorites_page/favorites_page.dart';
import 'package:spiccato/pages/history_page/history_page.dart';
import 'package:spiccato/pages/player_page/player_page.dart';
import 'package:spiccato/utils/palette.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  void _getDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        backgroundColor: Palette.background400,
        content: const Text('Недоступно на данный момент', style: TextStyle(color: Palette.white, fontSize: 18)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ОК', style: TextStyle(color: Palette.white, fontSize: 16)))
        ],
      ),
    );
  }

  final _pages = <Widget>[
    PlayerPage(),
    FavoritesPage(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background400,
      body: Column(
        children: [
          WindowBorder(
            color: Palette.background700,
            child: Row(
              children: [
                LeftSide(),
                RightSide(),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                NavigationRail(
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      label: Text('Главная'),
                      selectedIcon: Icon(Icons.home),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite_outline),
                      selectedIcon: Icon(Icons.favorite),
                      label: Text('Избранные'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.download_outlined),
                      selectedIcon: Icon(Icons.download),
                      label: Text('Импортировать'),
                    )
                  ],
                  trailing: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: _getDialog,
                          icon: const Icon(
                            Icons.more_horiz_outlined,
                            color: Palette.primary400,
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                  onDestinationSelected: (index) => setState(() {
                    currentIndex = index;
                  }),
                  selectedIndex: currentIndex,
                ),
                Expanded(
                  child: _pages.elementAt(
                    currentIndex,
                  ),
                ),
              ],
            ),
          )
          //
        ],
      ),
      // body:
    );
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: Container(
            color: Palette.background700,
            child: Column(
              children: [WindowTitleBarBox(child: MoveWindow())],
            )));
  }
}

class RightSide extends StatelessWidget {
  const RightSide({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Palette.background700,
        child: Column(children: [
          WindowTitleBarBox(
            child: Row(
              children: [Expanded(child: MoveWindow()), const WindowButtons()],
            ),
          )
        ]),
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: Palette.primary200,
    mouseOver: Palette.primary400,
    mouseDown: Palette.primary200,
    iconMouseOver: Palette.background700,
    iconMouseDown: Palette.background700);

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: Palette.primary200,
    iconMouseOver: Palette.background700);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
