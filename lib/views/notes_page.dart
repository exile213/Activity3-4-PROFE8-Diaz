import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _notesController = TextEditingController();
  String _displayedText = '';

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _handleCapture() {
    setState(() {
      _displayedText = _notesController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight Notes'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Flight Instructions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _notesController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter flight notes or instructions...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(text: 'Capture Text', onPressed: _handleCapture),
            const SizedBox(height: 30),
            if (_displayedText.isNotEmpty) ...[
              const Text(
                'Captured Text:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Text(
                  _displayedText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
