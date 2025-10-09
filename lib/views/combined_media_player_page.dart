import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';

/// Task 19: Combined video + audio player with play, pause, and stop buttons
class CombinedMediaPlayerPage extends StatefulWidget {
  const CombinedMediaPlayerPage({super.key});

  @override
  State<CombinedMediaPlayerPage> createState() =>
      _CombinedMediaPlayerPageState();
}

class _CombinedMediaPlayerPageState extends State<CombinedMediaPlayerPage>
    with TickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  late AudioPlayer _audioPlayer;
  late AnimationController _playButtonAnimationController;
  late Animation<double> _playButtonScaleAnimation;

  bool _isVideoInitialized = false;
  bool _isVideoPlaying = false;
  bool _isAudioPlaying = false;
  Duration _videoDuration = Duration.zero;
  Duration _videoPosition = Duration.zero;
  Duration _audioDuration = Duration.zero;
  Duration _audioPosition = Duration.zero;

  final String _videoAsset = 'assets/videos/video1.mp4';
  final String _audioAsset = 'assets/audio/booking-success.mp3';

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() async {
    // Initialize animation controller
    _playButtonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _playButtonScaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _playButtonAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    // Initialize video player
    _videoPlayerController = VideoPlayerController.asset(_videoAsset);
    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: false,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.blue,
        handleColor: Colors.blueAccent,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightBlue,
      ),
    );

    // Initialize audio player
    _audioPlayer = AudioPlayer();

    // Listen to video player changes
    _videoPlayerController.addListener(_updateVideoState);

    // Listen to audio player changes
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          _isAudioPlaying = state == PlayerState.playing;
        });
      }
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      if (mounted) {
        setState(() {
          _audioDuration = duration;
        });
      }
    });

    _audioPlayer.onPositionChanged.listen((Duration position) {
      if (mounted) {
        setState(() {
          _audioPosition = position;
        });
      }
    });

    if (mounted) {
      setState(() {
        _isVideoInitialized = true;
      });
    }
  }

  void _updateVideoState() {
    if (mounted) {
      setState(() {
        _isVideoPlaying = _videoPlayerController.value.isPlaying;
        _videoDuration = _videoPlayerController.value.duration;
        _videoPosition = _videoPlayerController.value.position;
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.removeListener(_updateVideoState);
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _audioPlayer.dispose();
    _playButtonAnimationController.dispose();
    super.dispose();
  }

  void _playPauseVideo() async {
    _playButtonAnimationController.forward().then((_) {
      _playButtonAnimationController.reverse();
    });

    if (_isVideoPlaying) {
      await _videoPlayerController.pause();
    } else {
      await _videoPlayerController.play();
    }
  }

  void _stopVideo() async {
    await _videoPlayerController.pause();
    await _videoPlayerController.seekTo(Duration.zero);
  }

  void _playPauseAudio() async {
    _playButtonAnimationController.forward().then((_) {
      _playButtonAnimationController.reverse();
    });

    if (_isAudioPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(
        AssetSource(_audioAsset.replaceFirst('assets/', '')),
      );
    }
  }

  void _stopAudio() async {
    await _audioPlayer.stop();
  }

  void _stopAllMedia() async {
    _stopVideo();
    _stopAudio();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Combined Media Player',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Video Player Section
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.videocam,
                          color: Colors.deepPurple.shade700,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Video Player',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Video player widget
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _isVideoInitialized && _chewieController != null
                            ? Chewie(controller: _chewieController!)
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Video progress bar
                    Row(
                      children: [
                        Text(
                          _formatDuration(_videoPosition),
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: _videoDuration.inMilliseconds > 0
                                ? _videoPosition.inMilliseconds /
                                      _videoDuration.inMilliseconds
                                : 0.0,
                            onChanged: (value) {
                              final position = Duration(
                                milliseconds:
                                    (_videoDuration.inMilliseconds * value)
                                        .round(),
                              );
                              _videoPlayerController.seekTo(position);
                            },
                            activeColor: Colors.deepPurple.shade700,
                          ),
                        ),
                        Text(
                          _formatDuration(_videoDuration),
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),

                    // Video controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ScaleTransition(
                          scale: _playButtonScaleAnimation,
                          child: ElevatedButton.icon(
                            onPressed: _playPauseVideo,
                            icon: Icon(
                              _isVideoPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                            label: Text(_isVideoPlaying ? 'Pause' : 'Play'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple.shade700,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _stopVideo,
                          icon: const Icon(Icons.stop),
                          label: const Text('Stop'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade600,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Audio Player Section
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.audiotrack,
                          color: Colors.orange.shade700,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Audio Player',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Audio visualization
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange.shade50,
                            Colors.orange.shade100,
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isAudioPlaying
                                ? Icons.graphic_eq
                                : Icons.music_note,
                            size: 48,
                            color: Colors.orange.shade700,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            _isAudioPlaying ? 'Playing...' : 'Ready to play',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                              color: Colors.orange.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Audio progress bar
                    Row(
                      children: [
                        Text(
                          _formatDuration(_audioPosition),
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: _audioDuration.inMilliseconds > 0
                                ? _audioPosition.inMilliseconds /
                                      _audioDuration.inMilliseconds
                                : 0.0,
                            onChanged: (value) {
                              final position = Duration(
                                milliseconds:
                                    (_audioDuration.inMilliseconds * value)
                                        .round(),
                              );
                              _audioPlayer.seek(position);
                            },
                            activeColor: Colors.orange.shade700,
                          ),
                        ),
                        Text(
                          _formatDuration(_audioDuration),
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),

                    // Audio controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ScaleTransition(
                          scale: _playButtonScaleAnimation,
                          child: ElevatedButton.icon(
                            onPressed: _playPauseAudio,
                            icon: Icon(
                              _isAudioPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                            label: Text(_isAudioPlaying ? 'Pause' : 'Play'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.shade700,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _stopAudio,
                          icon: const Icon(Icons.stop),
                          label: const Text('Stop'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade600,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Combined Controls Section
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.control_camera,
                          color: Colors.blue.shade700,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Combined Controls',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _stopAllMedia,
                      icon: const Icon(Icons.stop_circle),
                      label: const Text(
                        'Stop All Media',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
