import 'dart:async';
import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:spiccato/models/track.dart';

class PlayerProvider with ChangeNotifier {
  final List<Track> playlist = [];

  Track? _currentTrack;

  bool _isPlaying = false;

  bool _isDragging = false;

  Duration currentPositionTime = Duration.zero;
  Duration currentDurationTime = Duration.zero;

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

  void toggleIsDragging() {
    _isDragging = !_isDragging;

    notifyListeners();
  }

  void setCurrentTrack(Track track, [bool autoStart = false]) {
    if (_isPlaying) {
      _isPlaying = false;
      player.stop();
    }

    _currentTrack = track;

    player.open(Media.file(File(_currentTrack!.path)), autoStart: autoStart);
    if (autoStart) {
      _isPlaying = true;
    }
    notifyListeners();
  }

  Timer? timer;

  void playOrPause() {
    if (_isPlaying) {
      player.pause();
      timer?.cancel;
      toggleIsPlaying();
    } else {
      player.play();
      timer = Timer.periodic(const Duration(seconds: 1), (_) => _getTime());
      currentDurationTime = player.position.duration!;
      toggleIsPlaying();
    }
  }

  void _getTime() {
    currentDurationTime = player.position.duration!;
    currentPositionTime = player.position.position!;

    if (currentPositionTime >= currentDurationTime - Duration(seconds: 2)) {
      if (playlist.indexOf(_currentTrack!) != playlist.length - 1) {
        setCurrentTrack(playlist[playlist.indexOf(_currentTrack!) + 1], true);
      } else {
        setCurrentTrack(playlist.first, true);
      }
    }

    notifyListeners();
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

  void seek({required Duration to}) {
    player.seek(to);
  }

  Track? get currentTrack => _currentTrack;
  bool get isPlaying => _isPlaying;
  bool get isDragging => _isDragging;
}
