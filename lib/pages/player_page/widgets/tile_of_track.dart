import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:spiccato/models/track.dart';
import 'package:spiccato/provider/player_provider.dart';
import 'package:spiccato/utils/palette.dart';

class TrackTile extends StatefulWidget {
  const TrackTile({super.key, required this.track});

  final Track track;

  @override
  State<TrackTile> createState() => _TrackTileState();
}

class _TrackTileState extends State<TrackTile> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5.0),
      onHover: (event) => setState(() {
        onHover = !onHover;
      }),
      hoverColor: Palette.background700,
      onTap: () => context.read<PlayerProvider>().setCurrentTrack(widget.track),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: SizedBox(
                      width: 200,
                      child: Text(
                        '${Media.file(File(widget.track.path), parse: true).metas['title']}',
                        style: const TextStyle(color: Palette.white, fontFamily: 'IBM', fontWeight: FontWeight.w700),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: SizedBox(
                      width: 150,
                      child: Text(
                        '${Media.file(File(widget.track.path), parse: true).metas['artist']}',
                        style: const TextStyle(color: Palette.white, fontFamily: 'IBM'),
                      )),
                ),
                // SizedBox(
                //     width: 50,
                //     child: Text(
                //       '${widget.track.time.inSeconds}',
                //       style: const TextStyle(color: Palette.white, fontFamily: 'IBM'),
                //     )),
              ],
            ),
          ),
          Visibility(
            visible: onHover,
            child: Row(
              children: [
                TrackControlButton(
                    onTap: () => print(''),
                    icon: Icon(
                      Icons.star_border_outlined,
                      color: Palette.white.withOpacity(0.7),
                    )),
                TrackControlButton(
                    onTap: () => print(''),
                    icon: Icon(
                      Icons.playlist_add,
                      color: Palette.white.withOpacity(0.7),
                    )),
                TrackControlButton(
                    onTap: () => context.read<PlayerProvider>().removeFromPlaylist(widget.track),
                    icon: Icon(
                      Icons.remove,
                      color: Palette.white.withOpacity(0.7),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

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
        hoverColor: Color.alphaBlend(Palette.white.withOpacity(0.1), Palette.background400),
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
