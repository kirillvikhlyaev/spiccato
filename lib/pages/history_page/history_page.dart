import 'package:flutter/material.dart';
import 'package:spiccato/utils/palette.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'История',
        style: TextStyle(color: Palette.white, fontSize: 21),
      ),
    );
  }
}
