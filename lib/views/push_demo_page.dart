import 'package:flutter/material.dart';
import 'push_replacement_demo_page.dart';

class PushDemoPage extends StatelessWidget {
  const PushDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigator.push() Demo'),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.arrow_forward,
                size: 80,
                color: Color(0xFF77A1D3),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              color: const Color(0xFF77A1D3).withOpacity(0.1),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Navigator.push() Behavior:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF77A1D3),
                      ),
                    ),
                    SizedBox(height: 12),
                    NavigationPoint(
                      icon: Icons.add_circle_outline,
                      text: 'Adds a new screen to the navigation stack',
                    ),
                    NavigationPoint(
                      icon: Icons.arrow_back,
                      text: 'Previous screen remains in memory',
                    ),
                    NavigationPoint(
                      icon: Icons.history,
                      text:
                          'User can go back using back button or Navigator.pop()',
                    ),
                    NavigationPoint(
                      icon: Icons.layers,
                      text: 'Navigation stack grows (Screen A → Screen B)',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Try Navigation:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Using Navigator.push() - adds to stack
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PushReplacementDemoPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Go to pushReplacement Demo (using push)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF77A1D3),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Card(
              color: Color(0xFF79CBCA),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Notice: After navigating, you can use the back button to return here',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            const Center(
              child: Text(
                'Current Stack: [Main Screen] → [Push Demo] → ?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE684AE),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationPoint extends StatelessWidget {
  final IconData icon;
  final String text;

  const NavigationPoint({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF77A1D3), size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
