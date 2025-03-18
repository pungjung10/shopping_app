import 'package:flutter/material.dart';

class ShoppingDashboard extends StatefulWidget {
  const ShoppingDashboard({super.key});

  @override
  State<ShoppingDashboard> createState() => _ShoppingDashboardState();
}

class _ShoppingDashboardState extends State<ShoppingDashboard> {
  final List<String> products = [
    "Gourmet Fusion Pizza",
    "Organic Quinoa Salad",
    "Herb-Infused Bread",
    "Zesty Lemon Garlic Shrimp",
    "Berry Bliss Yogurt",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        String product = products[index];
        return Card(
          child: ListTile(
            leading: Icon(Icons.image, size: 50),
            title: Text(product),
            subtitle: Text("Price: \$${(index + 1) * 20}"),
            trailing: BlocBuilder<CartBloc, Map<String, int>>(
              builder: (context, cart) {
                int quantity = cart[product] ?? 0;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (quantity > 0)
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => context.read<CartBloc>().removeItem(product),
                      ),
                    Text(quantity.toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => context.read<CartBloc>().addItem(product),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
