import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.palette,
                        color: Theme.of(context).primaryColor,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Appearance',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Theme Toggle using Consumer to watch changes
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) {
                      return SwitchListTile(
                        title: const Text('Dark Mode'),
                        subtitle: Text(
                          themeProvider.isDarkMode
                              ? 'Switch to light theme'
                              : 'Switch to dark theme',
                        ),
                        value: themeProvider.isDarkMode,
                        onChanged: (value) {
                          // Demonstrates context.read() for one-time action
                          context.read<ThemeProvider>().toggleTheme();
                        },
                        secondary: Icon(
                          themeProvider.isDarkMode
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    },
                  ),

                  const Divider(),

                  // Theme Preview
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) {
                      return ListTile(
                        title: const Text('Theme Preview'),
                        subtitle: const Text(
                          'See how the app looks in different themes',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Light theme preview
                            GestureDetector(
                              onTap: () {
                                context.read<ThemeProvider>().setTheme(false);
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: !themeProvider.isDarkMode
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey,
                                    width: !themeProvider.isDarkMode ? 3 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.wb_sunny,
                                  color: Color(0xFF1976D2),
                                ),
                              ),
                            ),

                            // Dark theme preview
                            GestureDetector(
                              onTap: () {
                                context.read<ThemeProvider>().setTheme(true);
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF121212),
                                  border: Border.all(
                                    color: themeProvider.isDarkMode
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey,
                                    width: themeProvider.isDarkMode ? 3 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.nights_stay,
                                  color: Color(0xFF90CAF9),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // App Information Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.flight,
                        color: Theme.of(context).primaryColor,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'App Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Version'),
                    subtitle: const Text('1.0.0+1'),
                    contentPadding: EdgeInsets.zero,
                  ),

                  ListTile(
                    leading: const Icon(Icons.flight_takeoff),
                    title: const Text('Drone Surveying App'),
                    subtitle: const Text(
                      'Professional aerial survey booking service',
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),

                  ListTile(
                    leading: const Icon(Icons.code),
                    title: const Text('Built with Flutter'),
                    subtitle: const Text('State management with Provider'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Actions Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Theme.of(context).primaryColor,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Actions',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  ListTile(
                    leading: const Icon(Icons.refresh),
                    title: const Text('Reset App Settings'),
                    subtitle: const Text('Reset theme to default'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      _showResetDialog(context);
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.feedback),
                    title: const Text('Send Feedback'),
                    subtitle: const Text('Help us improve the app'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      _showFeedbackDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Demo section showing current theme values
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Card(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Theme Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildThemeDetail(
                        'Mode',
                        themeProvider.isDarkMode ? 'Dark' : 'Light',
                      ),
                      _buildThemeDetail(
                        'Primary Color',
                        Theme.of(context).primaryColor.toString(),
                      ),
                      _buildThemeDetail(
                        'Background',
                        Theme.of(context).scaffoldBackgroundColor.toString(),
                      ),
                      _buildThemeDetail(
                        'Surface',
                        Theme.of(context).colorScheme.surface.toString(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildThemeDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Settings'),
          content: const Text(
            'This will reset the theme to light mode. Continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ThemeProvider>().setTheme(false);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Settings reset to default'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Feedback'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Thank you for using our drone surveying app!'),
              SizedBox(height: 12),
              Text(
                'Your feedback helps us improve the theme switching feature and overall user experience.',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Thank you for your feedback!'),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }
}
