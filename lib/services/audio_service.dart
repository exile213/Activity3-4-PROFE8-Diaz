import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

/// Audio service for managing sound effects in the drone booking app
/// Demonstrates task 12: Audio feedback implementation
class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  late AudioPlayer _audioPlayer;
  bool _isInitialized = false;
  double _volume = 0.7;

  /// Initialize the audio service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _audioPlayer = AudioPlayer();
      _isInitialized = true;
      debugPrint('AudioService initialized successfully');
    } catch (e) {
      debugPrint('Error initializing AudioService: $e');
    }
  }

  /// Play booking success sound effect - uses your actual file: booking-success.mp3
  Future<void> playBookingSuccess() async {
    await _playSound('audio/booking-success.mp3');
  }

  /// Play a sound file with error handling
  Future<void> _playSound(String assetPath) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      await _audioPlayer.setVolume(_volume);
      await _audioPlayer.play(AssetSource(assetPath));
      debugPrint('Playing sound: $assetPath');
    } catch (e) {
      // Graceful handling - app continues to work without audio
      debugPrint('Could not play sound $assetPath: $e');
      debugPrint('Audio file missing - app continues without sound');
    }
  }

  /// Set audio volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    _volume = volume.clamp(0.0, 1.0);
    if (_isInitialized) {
      await _audioPlayer.setVolume(_volume);
    }
  }

  /// Get current volume
  double get volume => _volume;

  /// Pause any currently playing audio
  Future<void> pause() async {
    if (_isInitialized) {
      try {
        await _audioPlayer.pause();
      } catch (e) {
        debugPrint('Error pausing audio: $e');
      }
    }
  }

  /// Stop any currently playing audio
  Future<void> stop() async {
    if (_isInitialized) {
      try {
        await _audioPlayer.stop();
      } catch (e) {
        debugPrint('Error stopping audio: $e');
      }
    }
  }

  /// Dispose of resources
  Future<void> dispose() async {
    if (_isInitialized) {
      try {
        await _audioPlayer.dispose();
        _isInitialized = false;
      } catch (e) {
        debugPrint('Error disposing AudioService: $e');
      }
    }
  }

  /// Test audio functionality
  Future<bool> testAudio() async {
    try {
      await playBookingSuccess();
      return true;
    } catch (e) {
      debugPrint('Audio test failed: $e');
      return false;
    }
  }
}
