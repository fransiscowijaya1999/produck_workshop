import 'package:flutter/material.dart';
import 'package:produck_workshop/model/product.dart';

class ProductDropdownOverlay extends StatelessWidget {
  const ProductDropdownOverlay({
    super.key,
    required this.future,
    required this.currentIndex
  });

  final Future<List<Product>> future;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: FutureBuilder<List<Product>>(future: future, builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Center(child: const CircularProgressIndicator()),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Text('Error'),
              );
            } else {
              final products = snapshot.data!;

              return ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    minTileHeight: 0,
                    dense: true,
                    selected: currentIndex == index,
                    selectedTileColor: Colors.black.withAlpha(15),
                    title: Text(products[index].name)
                  );
                },
              );
            }
        }
      })
    );
  }
}