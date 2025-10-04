// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/custom_checkbox.dart';
import '../widgets/custom_switch.dart';
import '../widgets/custom_button.dart';

class ServiceOptionsPage extends StatefulWidget {
  const ServiceOptionsPage({Key? key}) : super(key: key);

  @override
  State<ServiceOptionsPage> createState() => _ServiceOptionsPageState();
}

class _ServiceOptionsPageState extends State<ServiceOptionsPage> {
  final TextEditingController _droneModelController = TextEditingController();
  bool _needPilotAssistance = false;
  bool _includeInsurance = false;

  @override
  void dispose() {
    _droneModelController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    String droneModel = _droneModelController.text.isNotEmpty
        ? _droneModelController.text
        : 'No preference';

    String message =
        '''
Service Options Saved!

Drone Model: $droneModel
Pilot Assistance: ${_needPilotAssistance ? 'Yes' : 'No'}
Insurance: ${_includeInsurance ? 'Included' : 'Not included'}
    ''';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Service Options'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surveying Options'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.settings, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Customize Your Surveying Service',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Select your preferences for drone surveying booking options.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // TextField for drone model preference
            CustomFormField(
              label: 'Drone Model Preference',
              hint: 'e.g., DJI Mavic, Phantom, etc.',
              controller: _droneModelController,
            ),

            const SizedBox(height: 30),
            const Text(
              'Additional Options',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Checkbox for pilot assistance
            CustomCheckbox(
              title: 'Need Pilot Assistance?',
              subtitle: 'Professional pilot will operate the drone',
              value: _needPilotAssistance,
              onChanged: (value) {
                setState(() {
                  _needPilotAssistance = value ?? false;
                });
              },
            ),

            const SizedBox(height: 16),

            // Switch for insurance
            CustomSwitch(
              title: 'Include Insurance?',
              subtitle: 'Protect your equipment and operations',
              value: _includeInsurance,
              onChanged: (value) {
                setState(() {
                  _includeInsurance = value;
                });
              },
            ),

            const SizedBox(height: 40),

            // Summary card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current Selection:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryRow(
                    Icons.flight,
                    'Drone Model',
                    _droneModelController.text.isEmpty
                        ? 'Not specified'
                        : _droneModelController.text,
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryRow(
                    Icons.people,
                    'Pilot Assistance',
                    _needPilotAssistance ? 'Required' : 'Not needed',
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryRow(
                    Icons.shield,
                    'Insurance',
                    _includeInsurance ? 'Included' : 'Not included',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            CustomButton(
              text: 'Save Options',
              onPressed: _handleSubmit,
              icon: Icons.save,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue[700]),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
        Expanded(
          child: Text(value, style: TextStyle(color: Colors.grey[700])),
        ),
      ],
    );
  }
}
