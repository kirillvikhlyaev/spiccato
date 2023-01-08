import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:spiccato/models/track.dart';

class PlayerProvider with ChangeNotifier {
  final List<Track> playlist = [
    Track(path: 'E:/05. Паника в селе.mp3'),
    Track(path: 'E:/06. Истинный убийца.mp3'),
    Track(path: 'E:/07. Лесник.mp3'),
  ];

  Track? _currentTrack;

  bool _isPlaying = false;

  final player = Player(id: 69420);

  void addTracksToPlaylist(Track tracks) {
    playlist.add(tracks);
    _currentTrack = playlist.first;

    notifyListeners();
  }

  void removeFromPlaylist(Track track) {
    if (_currentTrack == track) {
      if (playlist.indexOf(track) == playlist.length - 1) {
        _currentTrack = playlist.first;
      } else {
        _currentTrack = playlist[playlist.indexOf(track) + 1];
      }
      player.stop();
      toggleIsPlaying();
    }
    playlist.remove(track);
    notifyListeners();
  }

  void toggleIsPlaying() {
    _isPlaying = !_isPlaying;

    notifyListeners();
  }

  void setCurrentTrack(Track track) {
    if (_isPlaying) {
      _isPlaying = false;
      player.stop();
    }

    _currentTrack = track;
    notifyListeners();
  }

  void playOrPause() {
    if (_isPlaying) {
      player.pause();
      toggleIsPlaying();
    } else {
      player.open(Media.file(File(_currentTrack!.path)));
      player.play();
      toggleIsPlaying();
    }
  }

  void prevTrack() {
    if (playlist.length > 1) {
      if (_isPlaying) {
        player.stop();
        toggleIsPlaying();
      }

      if (playlist.indexOf(_currentTrack!) == 0) {
        _currentTrack = playlist.last;
      } else {
        _currentTrack = playlist[playlist.indexOf(_currentTrack!) - 1];
      }

      player.open(Media.file(File(_currentTrack!.path)));
      player.play();
      toggleIsPlaying();

      notifyListeners();
    }
  }

  void nextTrack() {
    if (playlist.length > 1) {
      if (_isPlaying) {
        player.stop();
        toggleIsPlaying();
      }

      if (playlist.indexOf(_currentTrack!) == playlist.length - 1) {
        _currentTrack = playlist.first;
      } else {
        _currentTrack = playlist[playlist.indexOf(_currentTrack!) + 1];
      }

      player.open(Media.file(File(_currentTrack!.path)));
      player.play();
      toggleIsPlaying();

      notifyListeners();
    }
  }

  Track? get currentTrack => _currentTrack;
  bool get isPlaying => _isPlaying;
}
