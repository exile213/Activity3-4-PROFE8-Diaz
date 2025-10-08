import 'package:flutter/material.dart';

class DroneFleetPage extends StatelessWidget {
  const DroneFleetPage({super.key});

  // Sample drone images from network - demonstrates task 7 (Image.network)
  final List<Map<String, String>> networkDroneImages = const [
    {
      'title': 'Professional Survey Drone',
      'description': 'High-precision mapping and surveying',
      'url':
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=300&fit=crop',
      'price': '\$2,500/day',
    },
    {
      'title': 'Mapping Specialist',
      'description': 'Advanced terrain mapping capabilities',
      'url':
          'https://images.unsplash.com/photo-1589149071751-ccdc2a5537cd?w=400&h=300&fit=crop',
      'price': '\$3,200/day',
    },
    {
      'title': 'Inspection Drone',
      'description': 'Infrastructure and building inspection',
      'url':
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=300&fit=crop',
      'price': '\$2,800/day',
    },
    {
      'title': 'Emergency Response',
      'description': 'Search and rescue operations',
      'url':
          'https://images.unsplash.com/photo-1629654637738-c8b8d100df85?w=400&h=300&fit=crop',
      'price': '\$3,500/day',
    },
    {
      'title': 'Agricultural Monitor',
      'description': 'Crop monitoring and analysis',
      'url':
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=300&fit=crop',
      'price': '\$2,200/day',
    },
    {
      'title': 'Security Patrol',
      'description': 'Perimeter monitoring and surveillance',
      'url':
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=300&fit=crop',
      'price': '\$2,600/day',
    },
  ];

  // Local asset images - demonstrates task 6 (Image.asset)
  final List<Map<String, String>> localDroneImages = const [
    {
      'title': 'Phantom Pro',
      'description': 'Professional aerial photography',
      'asset': 'assets/images/drone1.jpg',
      'price': '\$1,800/day',
    },
    {
      'title': 'Mavic Enterprise',
      'description': 'Compact professional drone',
      'asset': 'assets/images/drone1.jpg',
      'price': '\$2,100/day',
    },
    {
      'title': 'Inspire Mapping',
      'description': 'Heavy-duty mapping drone',
      'asset': 'assets/images/drone1.jpg',
      'price': '\$3,800/day',
    },
    {
      'title': 'Mini Survey',
      'description': 'Lightweight survey drone',
      'asset': 'assets/images/drone1.jpg',
      'price': '\$1,500/day',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drone Fleet Gallery'),
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
            // Tab Bar
            Container(
              color: Colors.blue.shade50,
              child: const TabBar(
                labelColor: Color(0xFF1976D2),
                unselectedLabelColor: Colors.grey,
                indicatorColor: Color(0xFF1976D2),
                tabs: [
                  Tab(icon: Icon(Icons.cloud_download), text: 'Network Images'),
                  Tab(icon: Icon(Icons.folder), text: 'Local Assets'),
                ],
              ),
            ),

            // Tab Views
            Expanded(
              child: TabBarView(
                children: [
                  // Network Images Tab - demonstrates task 7 (Image.network)
                  _buildNetworkImagesGrid(),

                  // Local Assets Tab - demonstrates task 6 (Image.asset)
                  _buildLocalAssetsGrid(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Demonstrates task 7: Image.network() with GridView (task 9)
  Widget _buildNetworkImagesGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Drones (Network Images)',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Images loaded from internet using Image.network()',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: networkDroneImages.length,
              itemBuilder: (context, index) {
                final drone = networkDroneImages[index];
                return _buildNetworkDroneCard(drone);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Demonstrates task 6: Image.asset() with GridView (task 9)
  Widget _buildLocalAssetsGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Premium Fleet (Local Assets)',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Images loaded from assets using Image.asset()',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: localDroneImages.length,
              itemBuilder: (context, index) {
                final drone = localDroneImages[index];
                return _buildLocalDroneCard(drone);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Network image card - demonstrates Image.network() (task 7)
  Widget _buildNetworkDroneCard(Map<String, String> drone) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Network image with loading indicator and error handling
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                drone['url']!,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.blue.shade50,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.blue.shade50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.flight,
                          size: 40,
                          color: Colors.blue.shade700,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Image not available',
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Drone details
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        drone['title']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        drone['description']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        drone['price']!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                      Icon(
                        Icons.network_wifi,
                        size: 16,
                        color: Colors.blue.shade700,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Local asset image card - demonstrates Image.asset() (task 6)
  Widget _buildLocalDroneCard(Map<String, String> drone) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Local asset image with error handling
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                drone['asset']!,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.orange.shade50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.flight_takeoff,
                          size: 40,
                          color: Colors.orange.shade700,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Asset not found',
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Drone details
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        drone['title']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        drone['description']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        drone['price']!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                      Icon(
                        Icons.folder,
                        size: 16,
                        color: Colors.orange.shade700,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
