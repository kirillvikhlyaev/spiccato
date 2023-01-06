import 'package:flutter/material.dart';
import 'package:spiccato/models/track.dart';
import 'package:spiccato/pages/player_page/widgets/tile_of_track.dart';

class ListOfTracks extends StatefulWidget {
  const ListOfTracks({super.key, required this.tracks});

  final List<Track> tracks;

  @override
  State<ListOfTracks> createState() => _ListOfTracksState();
}

class _ListOfTracksState extends State<ListOfTracks> {
  List<TrackTile> wrappedTracks = [];

  @override
  void initState() {
    wrappedTracks = widget.tracks.map((item) => TrackTile(track: item)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(itemBuilder: (context, index) => wrappedTracks[index], itemCount: wrappedTracks.length),
    );
  }
}
