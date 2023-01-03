import 'package:flutter/material.dart';
import 'package:spiccato/utils/palette.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Плеер',
        style: TextStyle(color: Palette.white, fontSize: 21),
      ),
    );
  }
}
