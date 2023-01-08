import 'package:flutter/material.dart';
import 'package:spiccato/models/track.dart';
import 'package:spiccato/pages/player_page/widgets/tile_of_track.dart';

class ListOfTracks extends StatelessWidget {
  const ListOfTracks({super.key, required this.tracks});

  final List<Track> tracks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          ListView.builder(itemBuilder: (context, index) => TrackTile(track: tracks[index]), itemCount: tracks.length),
    );
  }
}
