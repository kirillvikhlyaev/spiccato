import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spiccato/models/track.dart';
import 'package:spiccato/pages/player_page/widgets/list_of_tracks.dart';
import 'package:spiccato/provider/player_provider.dart';
import 'package:spiccato/utils/palette.dart';

import 'widgets/player_control_bar.dart';

class PlayerPage extends StatelessWidget {
  PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<PlayerProvider>().addTracksToPlaylist(tracks);
    final track = context.watch<PlayerProvider>().currentTrack;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
            child: ListOfTracks(
          tracks: context.watch<PlayerProvider>().playlist,
        )),
        Container(
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
                      onPressed: () => track != null ? context.read<PlayerProvider>().prevTrack() : null,
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
                      onPressed: () => track != null ? context.read<PlayerProvider>().playOrPause() : null,
                      icon: Icon(
                        context.watch<PlayerProvider>().isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
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
                      onPressed: () => track != null ? context.read<PlayerProvider>().nextTrack() : null,
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
        )
      ],
    );
  }
}
