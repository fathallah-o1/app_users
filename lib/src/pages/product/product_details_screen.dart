import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../home/home_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  final RestaurantItem product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int qty = 1;

  final addons = <Addon>[
    Addon('بيبسي', 3, 'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=600'),
    Addon('صوص ساموراي', 2, 'https://images.unsplash.com/photo-1559567781-5a5a0c4d0d7a?w=600'),
    Addon('بيبسي', 3, 'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=600'),
  ];
  final selected = <int, int>{}; // index -> count

  double get addonsPrice {
    double p = 0;
    selected.forEach((i, c) => p += addons[i].price * c);
    return p;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();
    final p = widget.product;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 280,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(children: [
                Positioned.fill(
                  child: Image.network(
                    p.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: const Color(0xFFE5E7EB)),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 40,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(.9),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.star_rate_rounded, color: Colors.amber),
                                Text(p.rating.toStringAsFixed(1)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(p.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                            const SizedBox(height: 6),
                            Text(p.tags.join(' - '), style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text('د.ل ${p.price.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  const Text('إضافات', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                  const SizedBox(height: 8),

                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: addons.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (_, i) {
                        final a = addons[i];
                        final count = selected[i] ?? 0;
                        return Container(
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    a.image,
                                    height: 60,
                                    width: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(Icons.image),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(a.name),
                                Text('د.ل ${a.price}', style: const TextStyle(color: Colors.grey)),
                              ],
                            ),
                            Positioned(
                              right: 6,
                              top: 6,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(children: [
                                  IconButton(
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () {
                                      setState(() => selected[i] = (count + 1));
                                      },
                                    icon: const Icon(Icons.add),
                                  ),
                                  if (count > 0) Text('$count'),
                                  if (count > 0)
                                    IconButton(
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () {
                                        setState(() {
                                          final v = (selected[i] ?? 0) - 1;
                                          if (v <= 0) {
                                            selected.remove(i);
                                          } else {
                                            selected[i] = v;
                                          }
                                        });
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                ]),
                              ),
                            ),
                          ]),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))],
          ),
          child: Row(children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.brown.shade700,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(children: [
                IconButton(
                  onPressed: () => setState(() => qty++),
                  icon: const Icon(Icons.add),
                  color: Colors.white,
                ),
                Text(' $qty ',
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () {
                    if (qty > 1) setState(() => qty--);
                  },
                  icon: const Icon(Icons.remove),
                  color: Colors.white,
                ),
              ]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  cart.addItem(
                    name: p.name,
                    basePrice: p.price,
                    qty: qty,
                    image: p.image,
                    addons: selected.entries
                        .map((e) => CartAddon(
                              name: addons[e.key].name,
                              price: addons[e.key].price,
                              qty: e.value,
                            ))
                        .toList(),
                  );
                  cart.openCart();
                },
                child: Text('إضافة إلى السلة • د.ل ${(p.price * qty + addonsPrice).toStringAsFixed(0)}'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
class Addon {
  final String name;
  final double price;
  final String image;
  Addon(this.name, this.price, this.image);
}
          
