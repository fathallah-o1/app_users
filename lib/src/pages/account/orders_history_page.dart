import 'package:flutter/material.dart';

class OrdersHistoryPage extends StatelessWidget {
  const OrdersHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder بسيط بنفس الروح
    return Scaffold(
      appBar: AppBar(title: const Text('سجل الطلبات')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) => Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
          child: Row(
            children: [
              const Icon(Icons.receipt_long_outlined),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: const [
                  Text('طلب #20250', style: TextStyle(fontWeight: FontWeight.w800)),
                  SizedBox(height: 4),
                  Text('حالة: مكتمل', style: TextStyle(color: Colors.grey)),
                ]),
              ),
              const Icon(Icons.chevron_left),
            ],
          ),
        ),
      ),
    );
  }
}