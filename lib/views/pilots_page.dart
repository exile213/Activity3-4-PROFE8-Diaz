import 'package:flutter/material.dart';
import '../widgets/profile_card.dart';

class PilotsPage extends StatelessWidget {
  const PilotsPage({super.key});

  // Sample pilot data
  final List<Map<String, dynamic>> pilots = const [
    {
      'name': 'Captain Sarah Johnson',
      'title': 'Lead Survey Pilot',
      'experience': '8 years',
      'specialization': 'Large-scale mapping and surveying',
      'rating': 4.9,
      'missions': 245,
      'imageUrl':
          'https://images.unsplash.com/photo-1494790108755-2616b9f44f34?w=200&h=200&fit=crop&crop=face',
      'localImage': 'assets/images/pilot1.jpg',
      'status': 'Available',
    },
    {
      'name': 'Commander Mike Torres',
      'title': 'Emergency Response Pilot',
      'experience': '12 years',
      'specialization': 'Search and rescue operations',
      'rating': 5.0,
      'missions': 189,
      'imageUrl':
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&h=200&fit=crop&crop=face',
      'localImage': 'assets/images/pilot1.jpg',
      'status': 'On Mission',
    },
    {
      'name': 'Dr. Emily Chen',
      'title': 'Agricultural Specialist',
      'experience': '6 years',
      'specialization': 'Crop monitoring and precision agriculture',
      'rating': 4.8,
      'missions': 156,
      'imageUrl':
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&h=200&fit=crop&crop=face',
      'localImage': 'assets/images/pilot1.jpg',
      'status': 'Available',
    },
    {
      'name': 'Lieutenant Alex Rodriguez',
      'title': 'Security Operations',
      'experience': '5 years',
      'specialization': 'Perimeter monitoring and surveillance',
      'rating': 4.7,
      'missions': 98,
      'imageUrl':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&crop=face',
      'localImage': 'assets/images/pilot1.jpg',
      'status': 'Available',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Pilots'),
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
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            // Header section
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue.shade50,
              child: Column(
                children: [
                  const Text(
                    'Professional Drone Pilots',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins', // Task 14: Custom font for title
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Meet our certified and experienced pilots',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontFamily: 'Roboto', // Task 14: Custom font for subtitle
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tab bar for different image styles
                  const TabBar(
                    labelColor: Color(0xFF1976D2),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Color(0xFF1976D2),
                    tabs: [
                      Tab(
                        icon: Icon(Icons.account_circle),
                        text: 'Network Images',
                      ),
                      Tab(icon: Icon(Icons.person), text: 'Local Assets'),
                    ],
                  ),
                ],
              ),
            ),

            // Tab views
            Expanded(
              child: TabBarView(
                children: [
                  // Network images with circular borders
                  _buildNetworkPilotsView(),

                  // Local asset images with circular borders
                  _buildLocalPilotsView(),
                ],
              ),
            ),

            // Task 15: Font styles showcase section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Font showcase title
                  const Text(
                    'Typography Showcase',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color(0xFF1976D2),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Poppins font family demonstration
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Poppins Font Family',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1976D2),
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Large Title',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Medium Heading',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Regular Text',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Small Caption',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins',
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Roboto font family demonstration
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Roboto Font Family',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1976D2),
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Professional Header',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Subheading Style',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Body Text Content',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Roboto',
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Caption Text',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto',
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Font style variations
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Style Variations',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1976D2),
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Bold & Poppins',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Italic Roboto',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.italic,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Light Poppins',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins',
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Heavy Roboto',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkPilotsView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pilots.length,
      itemBuilder: (context, index) {
        final pilot = pilots[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ProfileCard(
            name: pilot['name'],
            title: pilot['title'],
            imageUrl: pilot['imageUrl'],
            localImagePath: pilot['localImage'],
            customIcon: _getIconForSpecialization(pilot['specialization']),
            description:
                '${pilot['experience']} • ${pilot['specialization']} • ${pilot['missions']} missions',
            status: pilot['status'],
            rating: pilot['rating'].toDouble(),
            useNetworkImage: true,
          ),
        );
      },
    );
  }

  Widget _buildLocalPilotsView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pilots.length,
      itemBuilder: (context, index) {
        final pilot = pilots[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ProfileCard(
            name: pilot['name'],
            title: pilot['title'],
            imageUrl: pilot['imageUrl'],
            localImagePath: pilot['localImage'],
            customIcon: _getIconForSpecialization(pilot['specialization']),
            description:
                '${pilot['experience']} • ${pilot['specialization']} • ${pilot['missions']} missions',
            status: pilot['status'],
            rating: pilot['rating'].toDouble(),
            useNetworkImage: false,
          ),
        );
      },
    );
  }

  // Helper method to get appropriate icon for specialization
  IconData _getIconForSpecialization(String specialization) {
    if (specialization.contains('mapping') ||
        specialization.contains('surveying')) {
      return Icons.map_outlined;
    } else if (specialization.contains('rescue') ||
        specialization.contains('emergency')) {
      return Icons.medical_services_outlined;
    } else if (specialization.contains('landscape') ||
        specialization.contains('nature')) {
      return Icons.landscape_outlined;
    } else if (specialization.contains('construction') ||
        specialization.contains('infrastructure')) {
      return Icons.construction_outlined;
    } else {
      return Icons.flight_outlined;
    }
  }
}

// Task 15: Helper class for font style demonstrations
class FontStyleDemo {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final bool italic;

  const FontStyleDemo(
    this.text,
    this.fontSize,
    this.fontWeight,
    this.fontFamily, {
    this.italic = false,
  });
}
