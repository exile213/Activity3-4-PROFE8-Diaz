import 'package:flutter/material.dart';

class CustomTimePicker extends StatelessWidget {
  final String label;
  final TimeOfDay? selectedTime;
  final void Function(TimeOfDay) onTimeSelected;

  const CustomTimePicker({
    Key? key,
    required this.label,
    required this.selectedTime,
    required this.onTimeSelected,
  }) : super(key: key);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () => _selectTime(context),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            suffixIcon: const Icon(Icons.access_time),
          ),
          child: Text(
            selectedTime != null
                ? selectedTime!.format(context)
                : 'Select a time',
            style: TextStyle(
              fontSize: 16,
              color: selectedTime != null ? Colors.black : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}
