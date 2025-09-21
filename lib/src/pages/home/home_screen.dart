import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_theme.dart'; // مسموح يبقى حتى لو غير مستخدم الآن
import 'home_controller.dart';
import 'widgets/category_chip.dart';
import 'widgets/offer_card.dart';
import 'widgets/restaurant_card.dart';
import '../product/product_details_screen.dart'; // 👈 مهم للتنقل لصفحة التفاصيل

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
            const Text('توصيل إلى', style: TextStyle(fontSize: 12, color: Colors.grey)),
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => c.refreshData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Carousel (عروض مميزة) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CarouselSlider(
                    items: c.heroBanners.map((b) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            b.image,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Container(color: const Color(0xFFE5E7EB)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.black.withOpacity(0.3), Colors.transparent],
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
                                  b.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  b.subtitle,
                                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                                ),
                                const SizedBox(height: 12),
                                FilledButton.tonal(
                                  onPressed: () {},
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Colors.white.withOpacity(.9),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Text('الأقسام', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                    Spacer(),
                    Icon(Icons.chevron_left),
                    Text('عرض الكل'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 105,
                child: Obx(() {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: c.categories.length,
                    // ✅ تصحيح separatorBuilder
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (_, i) => CategoryChip(data: c.categories[i]),
                  );
                }),
              ),

              const SizedBox(height: 8),

              // --- العروض ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Text('عروض', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: OfferCard(
                  title: 'خصم 10%',
                  image: 'https://images.unsplash.com/photo-1550317138-10000687a72b?w=1200',
                  onTap: () {},
                ),
              ),

              const SizedBox(height: 16),

              // --- قائمة المطاعم / الأصناف ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('المطاعم المقترحة', style: Theme.of(context).textTheme.titleMedium),
              ),
              const SizedBox(height: 8),
              Obx(() {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: c.restaurants.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => RestaurantCard(
                    item: c.restaurants[i],
                    // ✅ فتح صفحة تفاصيل المنتج عند الضغط
                    onTap: () => Get.to(() => ProductDetailsScreen(product: c.restaurants[i])),
                  ),
                );
              }),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}