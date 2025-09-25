import 'package:flutter/material.dart';

class GeneralInfoPage extends StatelessWidget {
  const GeneralInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('معلومات عامة')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _InfoRow(label: 'الاسم', value: 'عبدالرحيم خالد'),
          _InfoRow(label: 'رقم الهاتف', value: '0928894771'),
          _InfoRow(label: 'البريد', value: 'user@example.com'),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label, value;
  const _InfoRow({required this.label, required this.value, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Expanded(child: Text(value, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w700))),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}