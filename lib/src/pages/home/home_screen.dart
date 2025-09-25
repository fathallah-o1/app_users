import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';
import 'widgets/category_chip.dart';
import 'widgets/restaurant_card.dart';
import '../product/product_details_screen.dart';
// ✅ جديد: شاشة عناصر القسم
import '../category/category_items_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('توصيل إلى',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('جوهرة', style: TextStyle(fontWeight: FontWeight.w800)),
                SizedBox(width: 4),
                Icon(Icons.keyboard_arrow_down, size: 18),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          const SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        if (c.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () async => c.fetchAll(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Carousel (العروض المميزة) ---
                if (c.restaurants.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CarouselSlider(
                        items: c.restaurants.map((item) {
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                item.image,
                                fit: BoxFit.cover,
                                // ✅ تصحيح errorBuilder
                                errorBuilder: (_, __, ___) =>
                                    Container(color: const Color(0xFFE5E7EB)),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.3),
                                      Colors.transparent
                                    ],
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 16,
                                top: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                      ),
                                      ),
                                    const SizedBox(height: 6),
                                    Text(
                                      item.description,
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 12),
                                    ),
                                    const SizedBox(height: 12),
                                    FilledButton.tonal(
                                      onPressed: () {
                                        Get.to(() => ProductDetailsScreen(
                                              product: item,
                                            ));
                                      },
                                      style: FilledButton.styleFrom(
                                        backgroundColor:
                                            Colors.white.withOpacity(.9),
                                        foregroundColor: Colors.black87,
                                      ),
                                      child: const Text('اطلب الآن'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 170,
                          viewportFraction: 1,
                          autoPlay: true,
                          enableInfiniteScroll: true,
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 16),
                // --- الأقسام ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: const [
                      Text('الأقسام',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 16)),
                      Spacer(),
                      Icon(Icons.chevron_left),
                      Text('عرض الكل'),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 105,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: c.categories.length,
                    // ✅ تصحيح separatorBuilder
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (_, i) {
                      final cat = c.categories[i];
                      // ✅ فتح شاشة القسم عند الضغط
                      return InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () => Get.to(
                          () => CategoryItemsScreen(category: cat),
                        ),
                        child: CategoryChip(data: cat),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),
                // --- قائمة المطاعم / الأصناف ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('المطاعم المقترحة',
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                const SizedBox(height: 8),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: c.restaurants.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => RestaurantCard(
                    item: c.restaurants[i],
                    onTap: () => Get.to(
                        () => ProductDetailsScreen(product: c.restaurants[i])),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      }),
    );
  }
}