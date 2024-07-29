import 'package:flutter/material.dart';
import 'package:pixel6/provider/customer_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer List"),
      ),
      body: Consumer<CustomerProvider>(
        builder: (context, customerProvider, child) {
          if (customerProvider.customers.isEmpty) {
            return const Center(child: Text("No customers found"));
          } else {
            return ListView.builder(
              itemCount: customerProvider.customers.length,
              itemBuilder: (context, index) {
                final customer = customerProvider.customers[index];
                return ListTile(
                  title: Text(customer.fullName),
                  subtitle: Text(customer.pan),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      customerProvider.deleteCustomer(index);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
