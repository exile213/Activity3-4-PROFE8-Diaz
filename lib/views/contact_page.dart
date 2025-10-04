import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
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
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.contact_phone,
                size: 80,
                color: Color(0xFFE684AE),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Emil\'s Drone Surveying',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ContactInfo(
              icon: Icons.phone,
              title: 'Phone',
              content: '+1 (555) 123-4567',
            ),
            SizedBox(height: 16),
            ContactInfo(
              icon: Icons.email,
              title: 'Email',
              content: 'info@emilsdrones.com',
            ),
            SizedBox(height: 16),
            ContactInfo(
              icon: Icons.language,
              title: 'Website',
              content: 'www.emilsdrones.com',
            ),
            SizedBox(height: 16),
            ContactInfo(
              icon: Icons.location_on,
              title: 'Address',
              content: '123 Drone Street\nAerial City, AC 12345\nUnited States',
            ),
            SizedBox(height: 30),
            Text(
              'Business Hours',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            BusinessHours(day: 'Monday - Friday', hours: '8:00 AM - 6:00 PM'),
            BusinessHours(day: 'Saturday', hours: '9:00 AM - 4:00 PM'),
            BusinessHours(day: 'Sunday', hours: 'Closed'),
            SizedBox(height: 30),
            Card(
              color: Color(0xFF77A1D3),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(Icons.flight_takeoff, size: 40, color: Colors.white),
                    SizedBox(height: 8),
                    Text(
                      'Ready to Schedule a Survey?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Contact us today for a free consultation and quote for your drone surveying needs.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Accessed via Named Routes: /contact',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF79CBCA),
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

class ContactInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const ContactInfo({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF77A1D3).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF77A1D3), size: 24),
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
                    content,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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

class BusinessHours extends StatelessWidget {
  final String day;
  final String hours;

  const BusinessHours({super.key, required this.day, required this.hours});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(hours, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}
