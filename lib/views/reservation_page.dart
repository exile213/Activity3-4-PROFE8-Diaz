import 'package:flutter/material.dart';
import '../widgets/custom_date_picker.dart';
import '../widgets/custom_time_picker.dart';
import '../widgets/custom_button.dart';
import '../services/audio_service.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _handleSubmit() async {
    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both date and time'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Task 12: Play booking success sound effect
    try {
      await AudioService().playBookingSuccess();
    } catch (e) {
      // Audio is optional - continue even if it fails
      debugPrint('Audio playback failed: $e');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Date and time confirmed! Go to Bookings to complete your survey booking.',
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Surveying Service'),
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
            const Text(
              'Schedule Drone Surveying Service',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            CustomDatePicker(
              label: 'Select Date',
              selectedDate: _selectedDate,
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
            const SizedBox(height: 20),
            CustomTimePicker(
              label: 'Select Time',
              selectedTime: _selectedTime,
              onTimeSelected: (time) {
                setState(() {
                  _selectedTime = time;
                });
              },
            ),
            const SizedBox(height: 40),
            CustomButton(text: 'Confirm Date & Time', onPressed: _handleSubmit),
          ],
        ),
      ),
    );
  }
}
