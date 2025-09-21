import 'package:flutter/material.dart';
import '../home_controller.dart';

class CategoryChip extends StatelessWidget {
  final Category data;
  const CategoryChip({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 72,
            height: 72,
            color: Colors.white,
            child: Image.network(
              data.image,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported_outlined),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(data.name, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    );
  }
}