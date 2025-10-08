import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TrainingVideosPage extends StatefulWidget {
  const TrainingVideosPage({super.key});

  @override
  State<TrainingVideosPage> createState() => _TrainingVideosPageState();
}

class _TrainingVideosPageState extends State<TrainingVideosPage> {
  VideoPlayerController? _controller;
  int _currentVideoIndex = 0;
  bool _isLoading = false;

  // Training videos data - demonstrates task 10 (video_player)
  final List<Map<String, String>> trainingVideos = [
    {
      'title': 'Drone Pre-Flight Inspection',
      'description':
          'Complete pre-flight safety checklist and equipment inspection',
      'duration': '3:45',
      'url':
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      'asset': 'assets/videos/preflight_inspection.mp4',
      'thumbnail':
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=300&h=200&fit=crop',
    },
    {
      'title': 'Safe Takeoff Procedures',
      'description': 'Learn proper takeoff techniques and safety protocols',
      'duration': '4:12',
      'url':
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      'asset': 'assets/videos/takeoff_procedures.mp4',
      'thumbnail':
          'https://images.unsplash.com/photo-1589149071751-ccdc2a5537cd?w=300&h=200&fit=crop',
    },
    {
      'title': 'Emergency Landing Protocol',
      'description': 'Emergency procedures and safe landing techniques',
      'duration': '5:30',
      'url':
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      'asset': 'assets/videos/emergency_landing.mp4',
      'thumbnail':
          'https://images.unsplash.com/photo-1629654637738-c8b8d100df85?w=300&h=200&fit=crop',
    },
    {
      'title': 'Weather Assessment',
      'description':
          'Understanding weather conditions for safe drone operations',
      'duration': '6:15',
      'url':
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
      'asset': 'assets/videos/weather_assessment.mp4',
      'thumbnail':
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=300&h=200&fit=crop',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeVideo(0);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo(int index) async {
    setState(() {
      _isLoading = true;
      _currentVideoIndex = index;
    });

    // Dispose previous controller
    await _controller?.dispose();

    // Create new controller - demonstrates task 10 (video_player package)
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(trainingVideos[index]['url']!),
    );

    try {
      await _controller!.initialize();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading video: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training Videos'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF77A1D3), Color(0xFF79CBCA), Color(0xFFE684AE)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Video Player Section - demonstrates task 10
          Container(
            height: 250,
            width: double.infinity,
            color: Colors.black,
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : _controller != null && _controller!.value.isInitialized
                ? Stack(
                    children: [
                      // Video player
                      SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: _controller!.value.size.width,
                            height: _controller!.value.size.height,
                            child: VideoPlayer(_controller!),
                          ),
                        ),
                      ),

                      // Video controls overlay
                      Positioned.fill(child: _buildVideoControls()),

                      // Video info overlay
                      Positioned(
                        top: 16,
                        left: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trainingVideos[_currentVideoIndex]['title']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                trainingVideos[_currentVideoIndex]['description']!,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Text(
                      'Failed to load video',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),

          // Video progress bar
          if (_controller != null && _controller!.value.isInitialized)
            VideoProgressIndicator(
              _controller!,
              allowScrubbing: true,
              colors: const VideoProgressColors(
                playedColor: Color(0xFF77A1D3),
                bufferedColor: Colors.grey,
                backgroundColor: Colors.black26,
              ),
            ),

          // Videos list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: trainingVideos.length,
              itemBuilder: (context, index) {
                final video = trainingVideos[index];
                final isSelected = index == _currentVideoIndex;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: isSelected ? Colors.blue.shade50 : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: isSelected
                        ? BorderSide(color: Colors.blue.shade300, width: 2)
                        : BorderSide.none,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Stack(
                      children: [
                        // Video thumbnail
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              video['thumbnail']!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.blue.shade100,
                                  child: Icon(
                                    Icons.play_circle_outline,
                                    color: Colors.blue.shade700,
                                    size: 30,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Play icon overlay
                        if (isSelected &&
                            _controller != null &&
                            _controller!.value.isPlaying)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.pause,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          )
                        else
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: Text(
                      video['title']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.blue.shade700 : null,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(video['description']!),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              video['duration']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const Spacer(),
                            if (isSelected)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade700,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'NOW PLAYING',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () => _initializeVideo(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoControls() {
    return GestureDetector(
      onTap: () {
        if (_controller != null && _controller!.value.isInitialized) {
          setState(() {
            if (_controller!.value.isPlaying) {
              _controller!.pause();
            } else {
              _controller!.play();
            }
          });
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _controller != null && _controller!.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
