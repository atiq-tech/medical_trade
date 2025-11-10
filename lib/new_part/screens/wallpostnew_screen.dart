import 'package:flutter/material.dart';
import 'package:medical_trade/new_part/providers/wall_postnew_provider.dart';
import 'package:provider/provider.dart';

class WallPostNewScreen extends StatefulWidget {
  const WallPostNewScreen({super.key});

  @override
  State<WallPostNewScreen> createState() => _WallPostNewScreenState();
}

class _WallPostNewScreenState extends State<WallPostNewScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
     Provider.of<WallPostNewProvider>(context, listen: false).getWallPostNew();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WallPostNewProvider>(context);
    final list = provider.allWallPostNewList;

    return Scaffold(
      appBar: AppBar(title: const Text("Wall Post List")),

      body: WallPostNewProvider.isWallPostNewLoading
          ? const Center(child: CircularProgressIndicator())

          : list.isEmpty ? const Center(child: Text("No Data Found"))

          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // grid এ কত column
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75, // card height adjust
                ),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final item = list[index];

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: item.image != null
                                  ? Image.network(
                                      "https://app.medicaltradeltd.com/${item.image}",
                                      fit: BoxFit.cover,
                                    )
                                  : const Center(child: Text("No Image")),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.title ?? "No Name",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text("Price: ${item.price}"),
                          Text("Model: ${item.model}"),
                          Text("Mobile: ${item.mobile}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

