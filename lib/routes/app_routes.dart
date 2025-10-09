import 'package:flutter/material.dart';
import '../views/login_entry_page.dart';
import '../views/welcome_page.dart';
import '../views/login_page.dart';
import '../views/register_page.dart';
import '../views/service_options_page.dart';
import '../views/reservation_page.dart';
import '../views/notes_page.dart';
import '../views/booking_history_page.dart';
import '../views/about_page.dart';
import '../views/contact_page.dart';
import '../views/push_demo_page.dart';
import '../views/messages_page.dart';
import '../views/settings_page.dart';
import '../views/drone_fleet_page.dart';
import '../views/pilots_page.dart';
import '../views/training_videos_page.dart';

/// Advanced navigation configuration for Task 16
/// Provides named routes with argument passing and type safety
class AppRoutes {
  // Route names as constants for type safety
  static const String loginEntry = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String serviceOptions = '/service-options';
  static const String reservation = '/reservation';
  static const String reservationWithData = '/reservation-with-data';
  static const String notes = '/notes';
  static const String bookingHistory = '/booking-history';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String pushDemo = '/push-demo';
  static const String messages = '/messages';
  static const String settings = '/settings';
  static const String droneFleet = '/drone-fleet';
  static const String pilots = '/pilots';
  static const String pilotDetail = '/pilot-detail';
  static const String trainingVideos = '/training-videos';
  static const String videoPlayer = '/video-player';

  /// Generate routes with argument support
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginEntry:
        return MaterialPageRoute(builder: (_) => const LoginEntryPage());

      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomePage());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case home:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case serviceOptions:
        return MaterialPageRoute(builder: (_) => const ServiceOptionsPage());

      case reservation:
        return MaterialPageRoute(builder: (_) => const ReservationPage());

      case reservationWithData:
        // Task 16: Route with arguments demonstration
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ReservationPageWithData(
            preSelectedService: args?['service'] as String?,
            preSelectedDate: args?['date'] as DateTime?,
          ),
        );

      case notes:
        return MaterialPageRoute(builder: (_) => const NotesPage());

      case bookingHistory:
        return MaterialPageRoute(builder: (_) => const BookingHistoryPage());

      case about:
        return MaterialPageRoute(builder: (_) => const AboutPage());

      case contact:
        return MaterialPageRoute(builder: (_) => const ContactPage());

      case pushDemo:
        return MaterialPageRoute(builder: (_) => const PushDemoPage());

      case messages:
        return MaterialPageRoute(builder: (_) => const MessagesPage());

      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());

      case droneFleet:
        return MaterialPageRoute(builder: (_) => const DroneFleetPage());

      case pilots:
        return MaterialPageRoute(builder: (_) => const PilotsPage());

      case pilotDetail:
        // Task 16: Pilot detail page with arguments
        final pilotData = settings.arguments as Map<String, dynamic>?;
        if (pilotData == null) {
          return _errorRoute('Pilot data is required');
        }
        return MaterialPageRoute(
          builder: (_) => PilotDetailPage(pilotData: pilotData),
        );

      case trainingVideos:
        return MaterialPageRoute(builder: (_) => const TrainingVideosPage());

      case videoPlayer:
        // Task 16: Video player with specific video data
        final videoData = settings.arguments as Map<String, String>?;
        if (videoData == null) {
          return _errorRoute('Video data is required');
        }
        return MaterialPageRoute(
          builder: (_) => VideoPlayerPage(videoData: videoData),
        );

      default:
        return _errorRoute('Route ${settings.name} not found');
    }
  }

  /// Error route for undefined routes
  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Navigation Error',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Task 16: Navigation helper methods
class NavigationHelper {
  /// Navigate to pilot detail with data
  static void goToPilotDetail(
    BuildContext context,
    Map<String, dynamic> pilotData,
  ) {
    Navigator.pushNamed(context, AppRoutes.pilotDetail, arguments: pilotData);
  }

  /// Navigate to reservation with pre-filled data
  static void goToReservationWithData(
    BuildContext context, {
    String? service,
    DateTime? date,
  }) {
    Navigator.pushNamed(
      context,
      AppRoutes.reservationWithData,
      arguments: {'service': service, 'date': date},
    );
  }

  /// Navigate to video player with specific video
  static void goToVideoPlayer(
    BuildContext context,
    Map<String, String> videoData,
  ) {
    Navigator.pushNamed(context, AppRoutes.videoPlayer, arguments: videoData);
  }

  /// Deep link navigation with validation
  static void navigateToDeepLink(
    BuildContext context,
    String path, {
    Map<String, dynamic>? arguments,
  }) {
    try {
      Navigator.pushNamed(context, path, arguments: arguments);
    } catch (e) {
      // Fallback navigation
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    }
  }
}

// Import the main screen from main.dart
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  List<Widget> get _pages => [
    const WelcomePage(),
    const ServiceOptionsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// Task 16: Enhanced pages with argument support

/// Enhanced reservation page that accepts pre-filled data
class ReservationPageWithData extends StatefulWidget {
  final String? preSelectedService;
  final DateTime? preSelectedDate;

  const ReservationPageWithData({
    super.key,
    this.preSelectedService,
    this.preSelectedDate,
  });

  @override
  State<ReservationPageWithData> createState() =>
      _ReservationPageWithDataState();
}

class _ReservationPageWithDataState extends State<ReservationPageWithData> {
  late String? selectedService;
  late DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedService = widget.preSelectedService;
    selectedDate = widget.preSelectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Service'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selectedService != null) ...[
              const Text(
                'Pre-selected Service:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(selectedService!, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
            ],
            if (selectedDate != null) ...[
              const Text(
                'Pre-selected Date:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                selectedDate!.toString().split(' ')[0],
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
            ],
            const Text('Task 16: Advanced Navigation with Arguments'),
            const Text(
              'This page demonstrates passing data through named routes.',
            ),
          ],
        ),
      ),
    );
  }
}

/// Task 16: Pilot detail page with argument data
class PilotDetailPage extends StatelessWidget {
  final Map<String, dynamic> pilotData;

  const PilotDetailPage({super.key, required this.pilotData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pilotData['name'] ?? 'Pilot Details'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pilotData['name'] ?? 'Unknown Pilot',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              pilotData['title'] ?? 'Professional Pilot',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(
                      'Experience',
                      pilotData['experience']?.toString() ?? 'N/A',
                    ),
                    _buildDetailRow(
                      'Specialization',
                      pilotData['specialization']?.toString() ?? 'N/A',
                    ),
                    _buildDetailRow(
                      'Rating',
                      '${pilotData['rating']?.toString() ?? 'N/A'} ⭐',
                    ),
                    _buildDetailRow(
                      'Missions',
                      pilotData['missions']?.toString() ?? 'N/A',
                    ),
                    _buildDetailRow(
                      'Status',
                      pilotData['status']?.toString() ?? 'N/A',
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }
}

/// Task 16: Video player page with specific video data
class VideoPlayerPage extends StatelessWidget {
  final Map<String, String> videoData;

  const VideoPlayerPage({super.key, required this.videoData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(videoData['title'] ?? 'Video Player'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            color: Colors.black,
            child: const Center(
              child: Icon(
                Icons.play_circle_fill,
                size: 64,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  videoData['title'] ?? 'Video Title',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  videoData['description'] ?? 'Video description',
                  style: const TextStyle(fontFamily: 'Roboto'),
                ),
                const SizedBox(height: 8),
                Text(
                  'Duration: ${videoData['duration'] ?? 'Unknown'}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
