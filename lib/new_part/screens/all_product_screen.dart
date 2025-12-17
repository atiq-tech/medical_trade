import 'package:flutter/material.dart';
import 'package:medical_trade/new_part/providers/all_products_provider.dart';
import 'package:provider/provider.dart';

// ধরুন আপনার model import আছে
// import 'your_model_file.dart';
// import 'your_api_service.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AllProductsProvider()..on()..getProducts("1"), // provider init + load
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Products'),
        ),
        body: Consumer<AllProductsProvider>(
          builder: (context, provider, _) {
            if (AllProductsProvider.isAllProductLoading) {
              // Loading indicator
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (provider.allProductslist.isEmpty) {
              return const Center(
                child: Text('No Products Found'),
              );
            } else {
              return ListView.builder(
                itemCount: provider.allProductslist.length,
                itemBuilder: (context, index) {
                  final product = provider.allProductslist[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                      leading: product.image != null
                          ? Image.network(
                              "https://app.medicaltradeltd.com/${product.image}",
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.image_not_supported),
                      title: Text(product.productName ?? "No Name"),
                      subtitle: Text("Price: ${product.price ?? "0"}"),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
