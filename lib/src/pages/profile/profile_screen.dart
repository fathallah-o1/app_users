import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الحساب')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(children: [
            const CircleAvatar(radius: 34, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12')),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: const [
              Text('عبدالرحيم خالد', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              Text('0928894771', style: TextStyle(color: Colors.grey)),
            ]),
            const Spacer(),
          ]),
          const SizedBox(height: 16),
          _section('معلومات عامة', Icons.person_outline),
          _section('العنوان', Icons.map_outlined),
          _section('سجل الطلبات', Icons.history),
          _section('السلة', Icons.shopping_bag_outlined),
          _section('المفضلة', Icons.favorite_border),
          _section('الإشعارات', Icons.notifications_none),
          _section('طرق الدفع', Icons.credit_card),
          _section('الإعدادات', Icons.settings_outlined),
          const SizedBox(height: 8),
          OutlinedButton(onPressed: () {}, child: const Text('تسجيل خروج')),
        ],
      ),
    );
  }

  Widget _section(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: const Color(0xFF7A3E12), borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.white, child: Icon(icon, color: const Color(0xFF7A3E12))),
        trailing: const Icon(Icons.chevron_left, color: Colors.white),
        title: Text(title, textAlign: TextAlign.right, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        onTap: () {},
      ),
    );
  }
}