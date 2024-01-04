import 'package:coldroom_product_management/utils/string_extensions.dart';
import 'package:flutter/material.dart';

class ProduceTypeCard extends StatelessWidget {
  final String image;
  final String name;
  final int remainQty;
  final int soldQty;
  final DateTime addedDate;

  const ProduceTypeCard({
    required this.image,
    required this.name,
    required this.remainQty,
    required this.soldQty,
    required this.addedDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Card(
        child: ListTile(
          isThreeLine: true,
          leading: ClipRRect(
            child: Image.network(
              image,
              width: 80,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          title: Text(
            name.capitalize(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Remain $remainQty Kg ",
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                "Sold $soldQty Kg",
                style: const TextStyle(fontSize: 14),
              )
            ],
          ),
          trailing: Column(
            children: [
              const Spacer(),
              Text(
                "${addedDate.day} /${addedDate.month}/${addedDate.year}",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
