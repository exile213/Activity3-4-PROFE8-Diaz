import 'package:flutter/material.dart';
import 'push_demo_page.dart';

class PushReplacementDemoPage extends StatelessWidget {
  const PushReplacementDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigator.pushReplacement() Demo'),
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
              child: Icon(Icons.swap_horiz, size: 80, color: Color(0xFFE684AE)),
            ),
            const SizedBox(height: 20),
            Card(
              color: const Color(0xFFE684AE).withOpacity(0.1),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Navigator.pushReplacement() Behavior:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE684AE),
                      ),
                    ),
                    SizedBox(height: 12),
                    NavigationPoint(
                      icon: Icons.swap_horizontal_circle,
                      text:
                          'Replaces the current screen in the navigation stack',
                    ),
                    NavigationPoint(
                      icon: Icons.delete_outline,
                      text: 'Previous screen is removed from memory',
                    ),
                    NavigationPoint(
                      icon: Icons.block,
                      text: 'User CANNOT go back to the replaced screen',
                    ),
                    NavigationPoint(
                      icon: Icons.layers_clear,
                      text:
                          'Navigation stack size stays the same (Screen A → Screen C)',
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
                  // Using Navigator.pushReplacement() - replaces current screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PushDemoPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.swap_horiz),
                label: const Text('Go to push Demo (using pushReplacement)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE684AE),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Regular Navigator.pop() to go back
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Go Back (Navigator.pop)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF79CBCA),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Card(
              color: Color(0xFFE684AE),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Notice: If you use pushReplacement, you cannot return to this screen with back button',
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
              child: Column(
                children: [
                  Text(
                    'Current Stack: [Main Screen] → [PushReplacement Demo]',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF77A1D3),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Push Demo was replaced, not stacked',
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
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
          Icon(icon, color: const Color(0xFFE684AE), size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
