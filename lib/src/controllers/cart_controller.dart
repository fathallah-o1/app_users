import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../pages/cart/cart_screen.dart';

class CartAddon {
  final String name;
  final double price;
  final int qty;
  const CartAddon({required this.name, required this.price, required this.qty});
}

class CartItem {
  final String name, image;
  final double basePrice;
  int qty;
  final List<CartAddon> addons;
  CartItem({
    required this.name,
    required this.image,
    required this.basePrice,
    required this.qty,
    this.addons = const [],
  });

  double get total =>
      basePrice * qty +
      addons.fold<double>(0, (p, a) => p + a.price * a.qty);
}

class CartController extends GetxController {
  final items = <CartItem>[].obs;

  int get count => items.fold(0, (p, e) => p + e.qty);
  double get subtotal => items.fold(0, (p, e) => p + e.total);
  double get delivery => items.isEmpty ? 0 : 6;
  double get services => 0;
  double get grandTotal => subtotal + delivery + services;

  void addItem({
    required String name,
    required String image,
    required double basePrice,
    required int qty,
    List<CartAddon> addons = const [],
  }) {
    items.add(CartItem(
      name: name,
      image: image,
      basePrice: basePrice,
      qty: qty,
      addons: addons,
    ));
    items.refresh();
  }

  void openCart() => Get.to(() => const CartScreen());
  void inc(int i) { items[i].qty++; items.refresh(); }
  void dec(int i) { if (items[i].qty > 1) items[i].qty--; else items.removeAt(i); items.refresh(); }
  void remove(int i) { items.removeAt(i); items.refresh(); }
}