import 'package:flutter/material.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/custom_button.dart';
import 'service_options_page.dart';
import 'gallery_carousel_page.dart';
import 'combined_media_player_page.dart';

class WelcomePage extends StatefulWidget {
  final Function(int)? onNavigateToTab;
  const WelcomePage({Key? key, this.onNavigateToTab}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final TextEditingController _usernameController = TextEditingController();
  String _submittedUsername = '';

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_usernameController.text.isNotEmpty) {
      setState(() {
        _submittedUsername = _usernameController.text;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Welcome, $_submittedUsername!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.flight_takeoff, size: 80, color: Colors.blue),
          const SizedBox(height: 20),
          const Text(
            'Welcome to Drone Surveying Booking',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins', // Task 16: Poppins font for titles
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Book professional drone surveying services for mapping, inspection, and aerial analysis.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontFamily: 'Roboto', // Task 16: Roboto font for descriptions
            ),
          ),
          const SizedBox(height: 20),

          // Task 16: Font styles demonstration
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Font Showcase - Task 16',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Color(0xFF1976D2),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Poppins Font Family:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Text(
                  'This text uses Poppins font - modern, clean, and perfect for headings and titles.',
                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Roboto Font Family:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                  ),
                ),
                const Text(
                  'This text uses Roboto font - professional, readable, and excellent for body text and descriptions.',
                  style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomFormField(
            label: 'Username',
            hint: 'Enter your username',
            controller: _usernameController,
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Submit',
            onPressed: _handleSubmit,
            icon: Icons.send,
          ),
          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 20),
          const Text(
            'Drone Surveying Services',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildServiceButton(
            'Service Options',
            'Customize drone model, pilot assistance, and insurance',
            Icons.settings,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ServiceOptionsPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildServiceButton(
            'Gallery Carousel',
            'View image gallery with smooth transitions',
            Icons.photo_library,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GalleryCarouselPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildServiceButton(
            'Media Player',
            'Combined video and audio player with controls',
            Icons.play_circle_filled,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CombinedMediaPlayerPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildServiceButton(
            'Book Surveying Service',
            'View and manage your drone survey bookings',
            Icons.book_online,
            () {
              // Navigate to Booking tab using callback
              if (widget.onNavigateToTab != null) {
                widget.onNavigateToTab!(1); // Booking tab index
              }
            },
          ),
          if (_submittedUsername.isNotEmpty) ...[
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Submitted Username:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _submittedUsername,
                    style: const TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildServiceButton(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.blue[700], size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
