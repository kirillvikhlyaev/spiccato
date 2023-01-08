import 'dart:io';
import 'dart:math';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
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
    final reader = context.read<PlayerProvider>();
    final watcher = context.watch<PlayerProvider>();

    final track = watcher.currentTrack;

    Widget listOrText() {
      if (watcher.playlist.isEmpty) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DottedBorder(
            color: Palette.white.withOpacity(0.3),
            borderType: BorderType.RRect,
            radius: const Radius.circular(16.0),
            dashPattern: [8, 6],
            strokeWidth: 4,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.download_outlined,
                    color: Palette.white,
                    size: 46,
                  ),
                  Text(
                    'Drop some music',
                    style: TextStyle(color: Palette.white, fontSize: 24, fontFamily: 'IBM'),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return ListOfTracks(
          tracks: watcher.playlist,
        );
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
            child: DropTarget(
          onDragDone: (details) {
            for (final file in details.files) {
              reader.addTracksToPlaylist(Track(path: file.path));
            }
          },
          onDragEntered: (_) => reader.toggleIsDragging(),
          onDragExited: (_) => reader.toggleIsDragging(),
          child: watcher.isDragging
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Palette.background700.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.download_outlined,
                            color: Palette.white,
                            size: 46,
                          ),
                          Text(
                            'Drop some music',
                            style: TextStyle(color: Palette.white, fontSize: 24, fontFamily: 'IBM'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : listOrText(),
        )),
        Container(
          color: Color.alphaBlend(Palette.primary400.withOpacity(0.1), Palette.background400),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ProgressBar(
                  onSeek: (value) => reader.seek(to: value),
                  progress: watcher.currentPositionTime,
                  total: watcher.currentDurationTime,
                  timeLabelTextStyle: TextStyle(color: Palette.white, fontFamily: 'IBM'),
                  thumbGlowRadius: 0.0,
                  progressBarColor: Palette.primary400,
                  baseBarColor: Palette.primary400.withOpacity(0.3),
                  thumbColor: Palette.primary400,
                  timeLabelType: TimeLabelType.remainingTime,
                ),
              ),
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
                      onPressed: () => track != null ? reader.prevTrack() : null,
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
                      onPressed: () => track != null ? reader.playOrPause() : null,
                      icon: Icon(
                        watcher.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
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
                      onPressed: () => track != null ? reader.nextTrack() : null,
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
