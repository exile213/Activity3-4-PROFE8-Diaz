import 'package:flutter/material.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/custom_date_picker.dart';
import '../widgets/custom_time_picker.dart';
import '../widgets/custom_button.dart';

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({Key? key}) : super(key: key);

  @override
  State<BookingHistoryPage> createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  final TextEditingController _serviceTypeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final List<Map<String, String>> _bookings = [];
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _serviceTypeController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _addBooking() {
    if (_serviceTypeController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _selectedDate == null ||
        _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields and select date/time'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _bookings.add({
        'serviceType': _serviceTypeController.text,
        'location': _locationController.text,
        'date':
            '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
        'time': _selectedTime!.format(context),
        'timestamp': DateTime.now().toString(),
      });
    });

    _serviceTypeController.clear();
    _locationController.clear();
    setState(() {
      _selectedDate = null;
      _selectedTime = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Survey booking added successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add New Survey Booking',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          CustomFormField(
            label: 'Survey Type',
            hint:
                'e.g., Aerial Survey, Land Mapping, Infrastructure Inspection',
            controller: _serviceTypeController,
          ),
          const SizedBox(height: 16),
          CustomFormField(
            label: 'Location',
            hint: 'e.g., Manila, Cebu, Project Site Address',
            controller: _locationController,
          ),
          const SizedBox(height: 16),
          CustomDatePicker(
            label: 'Select Date',
            selectedDate: _selectedDate,
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),
          const SizedBox(height: 16),
          CustomTimePicker(
            label: 'Select Time',
            selectedTime: _selectedTime,
            onTimeSelected: (time) {
              setState(() {
                _selectedTime = time;
              });
            },
          ),
          const SizedBox(height: 20),
          CustomButton(text: 'Add Survey Booking', onPressed: _addBooking),
          const SizedBox(height: 30),
          const Text(
            'All Survey Bookings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _bookings.isEmpty
                ? const Center(
                    child: Text(
                      'No survey bookings yet',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: _bookings.length,
                    itemBuilder: (context, index) {
                      final booking = _bookings[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue[700],
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(booking['serviceType']!),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('📍 ${booking['location']!}'),
                              if (booking['date'] != null &&
                                  booking['time'] != null)
                                Text(
                                  '📅 ${booking['date']} at ${booking['time']}',
                                ),
                            ],
                          ),
                          trailing: const Icon(Icons.flight),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
