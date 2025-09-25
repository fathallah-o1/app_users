import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../account/general_info_page.dart';
import '../account/address_map_page.dart';
import '../account/orders_history_page.dart';
import '../account/favorites_page.dart';
import '../account/notifications_page.dart';
import '../account/payment_methods_page.dart';
import '../account/settings_page.dart';
import '../cart/cart_screen.dart';

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

          _section('معلومات عامة', Icons.person_outline, onTap: () => Get.to(() => const GeneralInfoPage())),
          _section('العنوان', Icons.map_outlined, onTap: () => Get.to(() => const AddressMapPage())),
          _section('سجل الطلبات', Icons.history, onTap: () => Get.to(() => const OrdersHistoryPage())),
          _section('السلة', Icons.shopping_bag_outlined, onTap: () => Get.to(() => const CartScreen())),
          _section('المفضلة', Icons.favorite_border, onTap: () => Get.to(() => const FavoritesPage())),
          _section('الإشعارات', Icons.notifications_none, onTap: () => Get.to(() => const NotificationsPage())),
          _section('طرق الدفع', Icons.credit_card, onTap: () => Get.to(() => const PaymentMethodsPage())),
          _section('الإعدادات', Icons.settings_outlined, onTap: () => Get.to(() => const SettingsPage())),

          const SizedBox(height: 8),
          OutlinedButton(onPressed: () {}, child: const Text('تسجيل خروج')),
        ],
      ),
    );
  }

  static Widget _section(String title, IconData icon, {VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: const Color(0xFF7A3E12), borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.arrow_back_ios_new, color: Color(0xFF7A3E12), size: 18)),
        trailing: CircleAvatar(backgroundColor: Colors.white, child: Icon(icon, color: const Color(0xFF7A3E12))),
        title: Text(title, textAlign: TextAlign.right,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        onTap: onTap,
      ),
    );
  }
}