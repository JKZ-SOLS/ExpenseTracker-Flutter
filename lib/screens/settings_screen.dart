import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _iconTextRow(IconData icon, String label, {Widget? trailing}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[900],
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(label),
      trailing: trailing,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            _sectionTitle('Data Management'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _actionButton(Icons.download, 'Export Data'),
                  const SizedBox(width: 16),
                  _actionButton(Icons.upload, 'Import Data'),
                ],
              ),
            ),
            _sectionTitle('General'),
            _iconTextRow(Icons.attach_money, 'Currency',
                trailing: _dropdownButton(['PKR', 'USD', 'INR'])),
            _sectionTitle('Security'),
            _iconTextRow(Icons.lock, 'Change PIN', trailing: const Text('Change', style: TextStyle(color: Colors.green))),
            _iconTextRow(Icons.fingerprint, 'Fingerprint Unlock', trailing: Switch(value: true, onChanged: (_) {})),
            _sectionTitle('Reminders'),
            _iconTextRow(Icons.notifications, 'Daily Expense Reminder', trailing: const Text('Set up', style: TextStyle(color: Colors.green))),
            _sectionTitle('About'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(IconData icon, String label) {
    return Expanded(
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.green, size: 28),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _dropdownButton(List<String> items) {
    String selected = items[0];
    return DropdownButton<String>(
      dropdownColor: Colors.black,
      value: selected,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: const TextStyle(color: Colors.white)),
        );
      }).toList(),
      onChanged: (String? value) {
        // TODO: Add state management for currency
      },
    );
  }
}
