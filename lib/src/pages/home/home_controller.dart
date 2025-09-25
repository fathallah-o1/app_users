import 'package:get/get.dart';
import '../../core/api_service.dart';

class HomeController extends GetxController {
  final _api = ApiService();

  // ✅ الأقسام من القاعدة
  final categories = <Category>[].obs;

  // ✅ الأصناف/العروض المميزة من القاعدة
  final restaurants = <RestaurantItem>[].obs;

  // حالة تحميل
  final loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  Future<void> fetchAll() async {
    if (loading.value) return;
    loading.value = true;
    try {
      // 1) جلب الأقسام
      final cRes = await _api.get("/categories/list.php");
      if (cRes['ok'] == true && cRes['categories'] is List) {
        categories.value = (cRes['categories'] as List).map((e) {
          final m = e as Map;
          return Category(
            (m['name'] ?? '').toString(),
            (m['image_url'] ?? '').toString(),
            id: int.tryParse((m['id'] ?? '0').toString()), // ✅ نمرر id
          );
        }).toList();
      }

      // 2) جلب العروض (items مميزة)
      final iRes = await _api.get("/items/list.php", query: {'featured': '1'});
      if (iRes['ok'] == true && iRes['items'] is List) {
        restaurants.value = (iRes['items'] as List).map((j) {
          final m = j as Map;
          final price = double.tryParse((m['price'] ?? '0').toString()) ?? 0.0;
          final discount = (m['discount'] ?? 0).toString();
          return RestaurantItem(
            id: int.tryParse((m['id'] ?? '0').toString()) ?? 0,
            name: (m['name'] ?? '').toString(),
            image: (m['image_url'] ?? '').toString(),
            tags: const [], // لا يوجد جدول Tags حالياً
            rating: 4.6,    // قيمة مؤقتة لعدم وجود عمود rating في DB
            price: price,
            description: (m['description'] ?? '').toString(),
            discountText: (discount != '0' && discount != '0.00' && discount.isNotEmpty)
                ? 'خصم $discount%'
                : null,
          );
        }).toList();
      }
    } catch (e) {
      // تقدر تطبع الخطأ أو تعرض Snackbar
      // print("Error: $e");
    } finally {
      loading.value = false;
    }
  }
}

class Category {
  final String name, image;
  final int? id; // ✅ جديد: معرّف القسم من القاعدة
  Category(this.name, this.image, {this.id});
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