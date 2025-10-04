import 'package:flutter/material.dart';
import 'views/welcome_page.dart';
import 'views/login_page.dart';
import 'views/register_page.dart';
import 'views/service_options_page.dart';
import 'views/reservation_page.dart';
import 'views/notes_page.dart';
import 'views/booking_history_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drone Surveying Booking Service',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Pages for each tab - Three tabs: Home, Booking, Profile
  List<Widget> get _pages => [
    WelcomePage(
      onNavigateToTab: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    ), // Home
    const BookingHistoryPage(), // Booking
    const ProfileTab(), // Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emil\'s Drone Surveying'),
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
      drawer: _buildDrawer(context),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF77A1D3), Color(0xFF79CBCA), Color(0xFFE684AE)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_online),
              label: 'Booking',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF77A1D3),
                  Color(0xFF79CBCA),
                  Color(0xFFE684AE),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.flight_takeoff, size: 48, color: Colors.white),
                SizedBox(height: 8),
                Text(
                  'Emil\'s Drone Surveying',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Professional Aerial Services',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book_online, color: Color(0xFF77A1D3)),
            title: const Text('Booking'),
            subtitle: const Text('View and manage drone survey bookings'),
            onTap: () {
              Navigator.pop(context); // Close drawer
              // Navigate to Booking tab
              setState(() {
                _currentIndex = 1; // Booking tab index
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_outline, color: Color(0xFF79CBCA)),
            title: const Text('Profile'),
            subtitle: const Text('Login, Register, and Notes'),
            onTap: () {
              Navigator.pop(context); // Close drawer
              // Navigate to Profile tab
              setState(() {
                _currentIndex = 2; // Profile tab index
              });
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text('Exit App'),
            onTap: () {
              Navigator.pop(context);
              // In a real app, you might want to show a confirmation dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Exit functionality would be implemented here'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Placeholder for Services Tab
class ServicesTab extends StatelessWidget {
  const ServicesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const Icon(Icons.flight, size: 100, color: Colors.blue),
          const SizedBox(height: 40),
          const Text(
            'Drone Surveying Services',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Book your surveying service',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 40),
          _buildServiceButton(
            context,
            'Surveying Options',
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
          const SizedBox(height: 16),
          _buildServiceButton(
            context,
            'Book Surveying Service',
            'Schedule your drone surveying with date and time',
            Icons.calendar_today,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookingHistoryPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceButton(
    BuildContext context,
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
                child: Icon(icon, size: 32, color: Colors.blue[700]),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
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
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder for Bookings Tab

// Profile Tab with navigation to Login, Register, Notes
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const Icon(Icons.account_circle, size: 100, color: Colors.blue),
          const SizedBox(height: 20),
          const Text(
            'Account Management',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Manage your profile and account settings',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          const Text(
            'Authentication',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          _buildProfileButton(context, 'Login', Icons.login, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          }),
          const SizedBox(height: 16),
          _buildProfileButton(context, 'Register', Icons.person_add, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterPage()),
            );
          }),
          const SizedBox(height: 24),
          const Text(
            'Drone Operations',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          _buildProfileButton(context, 'Mission Notes', Icons.notes, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotesPage()),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProfileButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// Combined Services Tab for Task 3 - Three tabs only
class CombinedServicesTab extends StatelessWidget {
  const CombinedServicesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const Icon(Icons.business, size: 80, color: Colors.blue),
          const SizedBox(height: 20),
          const Text(
            'Drone Services',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Surveying & Booking Management',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 30),

          // Surveying Section
          const Text(
            'Surveying Options',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildServiceButton(
            context,
            'Service Customization',
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
            context,
            'Schedule Survey',
            'Select date and time for your drone survey',
            Icons.calendar_today,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReservationPage(),
                ),
              );
            },
          ),

          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 20),

          // Booking Management Section
          const Text(
            'Booking Management',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildServiceButton(
            context,
            'View Booking History',
            'See all your past and upcoming drone surveys',
            Icons.history,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookingHistoryPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceButton(
    BuildContext context,
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
