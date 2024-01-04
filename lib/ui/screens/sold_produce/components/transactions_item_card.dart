import 'package:coldroom_product_management/utils/string_extensions.dart';
import 'package:flutter/material.dart';

class TransactionItemCard extends StatelessWidget {
  String productName;
  String typeName;
  double soldPrice;
  int soldAmount;
  String date;
  String image;

  TransactionItemCard({
    required this.productName,
    required this.typeName,
    required this.soldAmount,
    required this.soldPrice,
    required this.date,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: ListTile(
        // isThreeLine: true,
        title: Text(
          productName.capitalize(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: Image.network(
          image,
          width: 80,
          fit: BoxFit.cover,
        ),
        subtitle: Text(
          "Price Birr $soldPrice",
          style: const TextStyle(fontSize: 14),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "$soldAmount KG",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(date,
                style: TextStyle(
                    fontSize: 14, color: Colors.black.withOpacity(0.8)))
          ],
        ),
      ),
    );
  }
}
