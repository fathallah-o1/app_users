import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(title: const Text('السلة')),
      body: Obx(() => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ...List.generate(c.items.length, (i) {
                final it = c.items[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(it.image, width: 64, height: 64, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.image)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Text(it.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                        const SizedBox(height: 4),
                        Text('د.ل ${it.total.toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                    ),
                    Column(children: [
                      IconButton(onPressed: () => c.remove(i), icon: const Icon(Icons.delete_outline)),
                      Row(children: [
                        IconButton(onPressed: () => c.inc(i), icon: const Icon(Icons.add_circle_outline)),
                        Text('${it.qty}'),
                        IconButton(onPressed: () => c.dec(i), icon: const Icon(Icons.remove_circle_outline)),
                      ]),
                    ]),
                  ]),
                );
              }),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(children: [
                  _line('سعر الأصناف', 'د.ل ${c.subtotal.toStringAsFixed(0)}'),
                  _line('التوصيل', 'د.ل ${c.delivery.toStringAsFixed(0)}'),
                  _line('الخدمات', 'د.ل ${c.services.toStringAsFixed(0)}'),
                  const Divider(),
                  _line('الإجمالي', 'د.ل ${c.grandTotal.toStringAsFixed(0)}', bold: true),
                ]),
              ),
              const SizedBox(height: 12),
              FilledButton(onPressed: () {}, child: const Padding(
                padding: EdgeInsets.all(14.0), child: Text('إتمام الطلب'),
              )),
              const SizedBox(height: 12),
            ],
          )),
    );
  }

  Widget _line(String k, String v, {bool bold = false}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(children: [
      Expanded(child: Text(k, textAlign: TextAlign.right,
        style: TextStyle(fontWeight: bold ? FontWeight.w800 : FontWeight.w500))),
      Text(v, style: TextStyle(fontWeight: bold ? FontWeight.w800 : FontWeight.w600)),
    ]),
  );
}