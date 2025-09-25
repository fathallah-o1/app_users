import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المفضلة')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: .8),
        itemCount: 4,
        itemBuilder: (_, i) => Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Expanded(child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network('https://picsum.photos/600?random=$i', fit: BoxFit.cover),
              )),
              const SizedBox(height: 8),
              const Text('اسم العنصر', style: TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}