import 'package:coldroom_product_management/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SummaryComponent extends StatefulWidget {
  int balance;
  int productInStore;

  SummaryComponent({
    required this.balance,
    required this.productInStore,
    Key? key,
  }) : super(key: key);

  @override
  State<SummaryComponent> createState() => _SummaryState();
}

class _SummaryState extends State<SummaryComponent> {
  bool isBalanceVisible = false;
  bool isProductInStoreVisible = false;

  toggleBalanceVisiblity() {
    setState(() {
      isBalanceVisible = !isBalanceVisible;
    });
  }

  toggleProductInStore() {
    setState(() {
      isProductInStoreVisible = !isProductInStoreVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: kSecondaryColor, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              const Text(
                "Balance",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Spacer(
                flex: 2,
              ),
              isBalanceVisible
                  ? Text(
                      "Birr ${widget.balance}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  : const Text(
                      "*********",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
            
              SizedBox(
                width: 20,
              ),

              IconButton(
                  onPressed: () {
                    toggleBalanceVisiblity();
                  },
                  icon: Icon(
                    isBalanceVisible
                        ? FontAwesomeIcons.solidEye
                        : FontAwesomeIcons.solidEyeSlash,
                    size: 16,
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: kSecondaryColor, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              const Text(
                "Product In Store",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Spacer(
                flex: 2,
              ),
              isProductInStoreVisible
                  ? Text(
                      "${widget.productInStore} KG",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  : const Text(
                      "*********",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
              SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: () {
                    toggleProductInStore();
                  },
                  icon: Icon(
                    isProductInStoreVisible
                        ? FontAwesomeIcons.solidEye
                        : FontAwesomeIcons.solidEyeSlash,
                    size: 16,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
