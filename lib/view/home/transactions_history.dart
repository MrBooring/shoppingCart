import 'package:appcart/controller/controllers/home_controller.dart';
import 'package:appcart/model/data_models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionListScreen extends StatelessWidget {
  final HomeController homeController = Get.find();

  TransactionListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transactions")),
      body: FutureBuilder<List<TransactionModel>>(
        future: homeController.fetchTransactions(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final transactions = snapshot.data!;
          if (transactions.isEmpty) {
            return const Center(child: Text("No transactions found."));
          }

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return ListTile(
                title: Text("Transaction #077${transaction.id}"),
                subtitle: Text("Date: ${transaction.date}\nTotal: \$${transaction.total - transaction.discount}"),
                trailing: Text("Saved: \$${transaction.discount}"),
              );
            },
          );
        },
      ),
    );
  }
}
