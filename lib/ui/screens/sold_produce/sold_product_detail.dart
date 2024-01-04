import 'package:coldroom_product_management/models/sold_product.dart';
import 'package:coldroom_product_management/utils/constants.dart';
import 'package:coldroom_product_management/utils/string_extensions.dart';
import 'package:flutter/material.dart';

class SoldProductDetail extends StatelessWidget {
  const SoldProductDetail({Key? key}) : super(key: key);
  static const String routeName = "/sold_product_detail";
  @override
  Widget build(BuildContext context) {
    final SoldProduct args =
        ModalRoute.of(context)!.settings.arguments as SoldProduct;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.productName.capitalize(),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: [
                const Text("Produce Name:"),
                const SizedBox(
                  width: 20,
                ),
                Text(args.productName.capitalize()),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: kSecondaryColor,
            width: double.infinity,
            child: Row(
              children: [
                const Text("Type Name:"),
                const SizedBox(
                  width: 20,
                ),
                Text(args.typeName.capitalize()),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            width: double.infinity,
            child: Row(
              children: [
                const Text("Sold amount:"),
                const SizedBox(
                  width: 20,
                ),
                Text('${args.soldAmount} KG'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: kSecondaryColor,
            width: double.infinity,
            child: Row(
              children: [
                const Text("Price:"),
                const SizedBox(
                  width: 20,
                ),
                Text('Birr ${args.soldPrice}'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: [
                const Text("Rent cost:"),
                const SizedBox(
                  width: 20,
                ),
                Text('Birr ${args.rentCost}'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: kSecondaryColor,
            width: double.infinity,
            child: Row(
              children: [
                const Text("Net:"),
                const SizedBox(
                  width: 20,
                ),
                Text('Birr ${args.netBalance}'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: Colors.white,
            width: double.infinity,
            child: Row(
              children: [
                const Text("Date:"),
                const SizedBox(
                  width: 20,
                ),
                Text('${args.date.day}/${args.date.month}/${args.date.year}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
