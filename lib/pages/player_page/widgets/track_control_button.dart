import 'package:flutter/material.dart';
import 'package:spiccato/utils/palette.dart';

class TrackControlButton extends StatelessWidget {
  const TrackControlButton({super.key, required this.onTap, required this.icon});

  final Widget icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(5.0),
        onTap: onTap,
        hoverColor: Palette.background400,
        splashColor: Color.alphaBlend(Palette.white.withOpacity(0.1), Palette.background400),
        highlightColor: Palette.background400,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: icon,
          ),
        ),
      ),
    );
  }
}
