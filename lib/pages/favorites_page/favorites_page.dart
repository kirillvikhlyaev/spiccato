import 'package:flutter/material.dart';
import 'package:spiccato/utils/palette.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Избранные',
        style: TextStyle(color: Palette.white, fontSize: 21),
      ),
    );
  }
}
