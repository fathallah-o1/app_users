import 'package:flutter/material.dart';
import '../home_controller.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantItem item;
  final VoidCallback? onTap;
  const RestaurantCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Stack(children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  item.image,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: const Color(0xFFE5E7EB)),
                ),
              ),
              if (item.discountText != null)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.brown.shade700, borderRadius: BorderRadius.circular(12)),
                    child: Text(item.discountText!, style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(item.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(item.tags.join(' - '), style: const TextStyle(color: Colors.grey)),
                ]),
              ),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  const Icon(Icons.star_rate_rounded, color: Colors.amber, size: 18),
                  Text(item.rating.toStringAsFixed(1)),
                ]),
                const SizedBox(height: 6),
                Text('د.ل ${item.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}