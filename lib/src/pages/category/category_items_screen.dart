import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/api_service.dart';
import '../home/home_controller.dart';
import '../home/widgets/restaurant_card.dart';
import '../product/product_details_screen.dart';

class CategoryItemsScreen extends StatefulWidget {
  final Category category;
  const CategoryItemsScreen({super.key, required this.category});

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  final _api = ApiService();
  final _items = <RestaurantItem>[].obs;
  final _loading = true.obs;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (widget.category.id == null) { _loading.value = false; return; }
    try {
      final r = await _api.get("/items/list.php", query: {
        'category_id': widget.category.id.toString(),
      });
      if (r['ok'] == true && r['items'] is List) {
        _items.value = (r['items'] as List).map((j) {
          final m = j as Map;
          return RestaurantItem(
            id: int.tryParse((m['id'] ?? '0').toString()) ?? 0,
            name: (m['name'] ?? '').toString(),
            image: (m['image_url'] ?? '').toString(),
            tags: const [],
            rating: 4.6,
            price: double.tryParse((m['price'] ?? '0').toString()) ?? 0,
            description: (m['description'] ?? '').toString(),
            discountText: ((m['discount'] ?? '0').toString() != '0' &&
                    (m['discount'] ?? '0').toString() != '0.00')
                ? 'خصم ${m['discount']}%'
                : null,
          );
        }).toList();
      }
    } finally {
      _loading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.name)),
      body: Obx(() {
        if (_loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_items.isEmpty) {
          return const Center(child: Text('لا توجد أصناف لهذا القسم حالياً'));
        }
        return RefreshIndicator(
          onRefresh: _load,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) => RestaurantCard(
              item: _items[i],
              onTap: () => Get.to(() => ProductDetailsScreen(product: _items[i])),
            ),
          ),
        );
      }),
    );
  }
}