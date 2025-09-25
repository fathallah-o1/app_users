import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('طرق الدفع')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _tile('نقدًا عند الاستلام', Icons.payments_outlined, selected: true),
          _tile('بطاقة محلية', Icons.credit_card_outlined),
          _tile('محفظة إلكترونية', Icons.account_balance_wallet_outlined),
        ],
      ),
    );
  }

  Widget _tile(String t, IconData i, {bool selected = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(14),
        border: Border.all(color: selected ? const Color(0xFF7A3E12) : const Color(0xFFE5E7EB)),
      ),
      child: ListTile(
        leading: Icon(i),
        trailing: selected ? const Icon(Icons.check_circle, color: Color(0xFF7A3E12)) : null,
        title: Text(t, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w700)),
        onTap: () {},
      ),
    );
  }
}