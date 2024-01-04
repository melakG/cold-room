import 'package:flutter/material.dart';
import 'components/produce_detail_card.dart';

class MyProduce extends StatelessWidget {
  static const String routeName = "/my-product";
  const MyProduce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Produce"),
      ),
      body: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return const ProduceDetailCard(
              image: "assets/images/download.jpg",
              name: "Tomato",
              mass: 200,
              rentPrice: 200,
            );
          }),
    );
  }
}
