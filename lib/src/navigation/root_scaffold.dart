import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/home/home_screen.dart';
import '../pages/search/search_screen.dart';
import '../pages/orders/orders_screen.dart';
import '../pages/profile/profile_screen.dart';
import '../controllers/cart_controller.dart';

class RootController extends GetxController {
  final current = 0.obs;
  final pages = const [HomeScreen(), SearchScreen(), OrdersScreen(), ProfileScreen()];
  void switchTo(int i) => current.value = i;
}

class RootScaffold extends StatelessWidget {
  const RootScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CartController()); // متاح لكل الصفحات
    final c = Get.put(RootController());
    return Obx(() => Scaffold(
          body: c.pages[c.current.value],
          bottomNavigationBar: NavigationBar(
            selectedIndex: c.current.value,
            onDestinationSelected: c.switchTo,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_outlined), label: 'الرئيسية'),
              NavigationDestination(icon: Icon(Icons.search), label: 'بحث'),
              NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'طلباتي'),
              NavigationDestination(icon: Icon(Icons.person_outline), label: 'حسابي'),
            ],
          ),
        ));
  }
}