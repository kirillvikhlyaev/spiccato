import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:spiccato/models/track.dart';
import 'package:spiccato/pages/player_page/widgets/list_of_tracks.dart';
import 'package:spiccato/utils/palette.dart';

import 'widgets/player_control_bar.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late Player player;
  final track = Track(name: 'Saints', author: 'Row', time: Duration(minutes: 1, seconds: 30), path: 'D:/saints.mp3');

  @override
  void initState() {
    player = Player(id: 69420);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
            child: ListOfTracks(
          tracks: [track],
        )),
        PlayerControlBar(
          player: player,
          track: track,
        ),
      ],
    );
  }
}
