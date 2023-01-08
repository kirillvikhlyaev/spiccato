// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';

class Track {
  String name;
  String author;
  final String path;

  Track({
    this.name = '',
    this.author = '',
    required this.path,
  }) {
    name = Media.file(File(path), parse: true).metas['title'] ?? 'Unknown';
    author = Media.file(File(path), parse: true).metas['artist'] ?? 'Unknown';
  }

  Track.temp({this.name = 'God`s Plan', this.author = 'Drake', this.path = ''});

  @override
  String toString() => 'Track(name: $name, author: $author)';
}
