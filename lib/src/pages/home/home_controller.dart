import 'package:get/get.dart';

class HomeController extends GetxController {
  // البانرات
  final heroBanners = <_Banner>[
    _Banner(
      image: 'https://images.unsplash.com/photo-1550317138-10000687a72b?w=1400',
      title: 'مع عيلتي',
      subtitle: 'بوكس بيتزا + مشروبات',
    ),
    _Banner(
      image: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=1400',
      title: 'ألذ برغر',
      subtitle: 'لحم طازج وجبن ذايب',
    ),
  ].obs;

  // 👈 الأقسام (المفقودة سابقًا)
  final categories = <Category>[
    Category('بيتزا',
        'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400'),
    Category('هامبورغر',
        'https://images.unsplash.com/photo-1550547660-d9450f859349?w=400'),
    Category('شاورما',
        'https://images.unsplash.com/photo-1617692855027-2e7a0d4bcee2?w=400'),
  ].obs;

  // الأصناف/المطاعم
  final restaurants = <RestaurantItem>[
    RestaurantItem(
      id: 1,
      name: 'العيد الكبير',
      rating: 4.7,
      image: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=1200',
      tags: ['لحم', 'خس', 'جبنة', 'صلصات', 'بصل'],
      price: 12,
      description: 'برغر لحم طازج مع جبنة ذايبة وخس وصوصات خاصة.',
      discountText: '٪10 خصم',
    ),
    RestaurantItem(
      id: 2,
      name: 'مشاوي الضيعة',
      rating: 4.5,
      image: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=1200',
      tags: ['مشاوي', 'سندوتشات'],
      price: 18,
      description: 'سندوتشات مشاوي مشكلة مع تتبيلة مميزة.',
    ),
  ].obs;

  Future<void> refreshData() async =>
      Future.delayed(const Duration(milliseconds: 600));
}

class Category {
  final String name, image;
  Category(this.name, this.image);
}

class RestaurantItem {
  final int id;
  final String name, image;
  final List<String> tags;
  final double rating;
  final double price;
  final String description;
  final String? discountText;
  RestaurantItem({
    required this.id,
    required this.name,
    required this.image,
    required this.tags,
    required this.rating,
    required this.price,
    required this.description,
    this.discountText,
  });
}

class _Banner {
  final String image, title, subtitle;
  _Banner({required this.image, required this.title, required this.subtitle});
}