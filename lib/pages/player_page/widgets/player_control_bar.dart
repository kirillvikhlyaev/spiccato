import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:spiccato/models/track.dart';
import 'package:spiccato/utils/palette.dart';

class PlayerControlBar extends StatelessWidget {
  PlayerControlBar({super.key, required this.player, required this.track});

  final Player player;
  final Track? track;

  bool isPlaying = false;
  double sliderValue = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.track != null) {
  //     widget.player.open(Media.file(File(widget.track!.path)), autoStart: false);
  //   }
  // }

  void play() {
    // if (isPlaying) {
    //   widget.player.pause();
    // } else {
    //   widget.player.play();
    // }
    // setState(() {
    //   isPlaying = !isPlaying;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.alphaBlend(Palette.primary400.withOpacity(0.1), Palette.background400),
      child: Column(
        children: [
          //Слайдер
          const SizedBox(height: 10),
          Column(
            children: [
              Text(track != null ? track!.name : 'Unknown',
                  style: const TextStyle(color: Palette.white, fontSize: 16, fontWeight: FontWeight.w700)),
              Text(track != null ? track!.author : 'Unknown',
                  style: const TextStyle(color: Palette.white, fontSize: 14, fontWeight: FontWeight.w400)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  onPressed: () => print('ad'),
                  icon: const Icon(
                    Icons.skip_previous_rounded,
                    color: Palette.primary200,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  onPressed: play,
                  icon: Icon(
                    isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: Palette.primary200,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  onPressed: () => print('ad'),
                  icon: const Icon(
                    Icons.skip_next_rounded,
                    color: Palette.primary200,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
