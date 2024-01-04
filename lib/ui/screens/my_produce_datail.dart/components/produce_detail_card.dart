import 'package:flutter/material.dart';

class ProduceDetailCard extends StatelessWidget {
  final String image;
  final String name;
  final double mass;
  final double rentPrice;
  const ProduceDetailCard({
    required this.image,
    required this.name,
    required this.mass,
    required this.rentPrice,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        leading: ClipRRect(
          child: Image.asset(image),
          borderRadius: BorderRadius.circular(5),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Text("Rent Birr $rentPrice"),
        trailing: Text("$mass Kg"),
      ),
    );
  }
}
