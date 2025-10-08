import 'package:flutter/material.dart';

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
        return _buildPilotCard(pilot, useNetwork: true);
      },
    );
  }

  Widget _buildLocalPilotsView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pilots.length,
      itemBuilder: (context, index) {
        final pilot = pilots[index];
        return _buildPilotCard(pilot, useNetwork: false);
      },
    );
  }

  Widget _buildPilotCard(
    Map<String, dynamic> pilot, {
    required bool useNetwork,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                // Circular profile image - demonstrates task 8 (BoxDecoration circular borders)
                _buildCircularProfileImage(pilot, useNetwork),

                const SizedBox(width: 16),

                // Pilot details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pilot['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins', // Task 14: Custom font
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pilot['title'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto', // Task 14: Custom font
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${pilot['rating']}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.flight,
                            size: 16,
                            color: Colors.blue.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${pilot['missions']} missions',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Status indicator with circular design
                _buildStatusIndicator(pilot['status']),
              ],
            ),

            const SizedBox(height: 16),

            // Additional pilot information
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          Icons.schedule,
                          'Experience',
                          pilot['experience'],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey.shade300,
                      ),
                      Expanded(
                        child: _buildInfoItem(
                          useNetwork ? Icons.cloud : Icons.folder,
                          'Image Source',
                          useNetwork ? 'Network' : 'Local Asset',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Specialization: ${pilot['specialization']}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Demonstrates task 8: Circular borders using BoxDecoration
  Widget _buildCircularProfileImage(
    Map<String, dynamic> pilot,
    bool useNetwork,
  ) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue.shade300, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: useNetwork
            ? Image.network(
                pilot['imageUrl'],
                width: 74,
                height: 74,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.blue.shade50,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.blue.shade50,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.blue.shade700,
                    ),
                  );
                },
              )
            : Image.asset(
                pilot['localImage'],
                width: 74,
                height: 74,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.orange.shade50,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.orange.shade700,
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildStatusIndicator(String status) {
    Color statusColor = status == 'Available' ? Colors.green : Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20), // Circular borders for status
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Circular status indicator
              color: statusColor,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.blue.shade600),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
