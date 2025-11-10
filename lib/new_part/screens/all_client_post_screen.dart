import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/client_post_provider.dart';

class ClientPostScreen extends StatefulWidget {
  const ClientPostScreen({super.key});

  @override
  State<ClientPostScreen> createState() => _ClientPostScreenState();
}

class _ClientPostScreenState extends State<ClientPostScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<NewClientPostProvider>(context, listen: false)
          .getClientPost();

    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewClientPostProvider>(context);
    final list = provider.allClientPostList;

    return Scaffold(
      appBar: AppBar(title: const Text("Client Post List")),

      body: NewClientPostProvider.isAllClientPostLoading
          ? const Center(child: CircularProgressIndicator())

          : list.isEmpty
              ? const Center(child: Text("No Data Found"))

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
                                item.machineName ?? "No Name",
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

