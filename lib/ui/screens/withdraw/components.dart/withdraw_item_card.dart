import 'package:coldroom_product_management/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WithdrawItemCart extends StatelessWidget {
  String date;
  int amount;

  WithdrawItemCart({
    required this.date,
    required this.amount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(
          FontAwesomeIcons.check,
          size: 24,
          color: kPrimaryColor,
        ),
        trailing: Text(date,
            style: const TextStyle(
                fontSize: 14, color: Color.fromRGBO(0, 0, 0, 0.5))),
        title: Text("Birr $amount",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
