import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool notif = true;
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: StatefulBuilder(
              builder: (_, setState) => Row(
                children: [
                  Switch(value: notif, onChanged: (v) => setState(() => notif = v)),
                  const Spacer(),
                  const Text('تفعيل الإشعارات'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: const [
                Icon(Icons.language),
                Spacer(),
                Text('اللغة: العربية'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}