import 'package:coldroom_product_management/controller/sold_product_controller.dart';
import 'package:coldroom_product_management/models/sold_product.dart';
import 'package:coldroom_product_management/ui/screens/sold_produce/sold_product_detail.dart';
import 'package:coldroom_product_management/utils/constants.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'components/transactions_item_card.dart';

class SoldProduce extends StatelessWidget {
  static const String routeName = "/sold-produce";
  const SoldProduce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
          future: fetchSoldProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Faild to load data'),
                );
              } else if (snapshot.hasData) {
                List<SoldProduct> soldProducts =
                    snapshot.data as List<SoldProduct>;

                double totalSold = soldProducts.fold(
                    0, (total, item) => total += item.soldPrice);

                return soldProducts.isEmpty
                    ? const Center(
                        child: Text("No sold produce yet!"),
                      )
                    : SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppBar(
                              title: const Text("Sold Produce"),
                              elevation: 0,
                              leading: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(
                                      Icons.arrow_back_ios_new_outlined)),
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: size.height * 0.2,
                                  padding: EdgeInsets.only(bottom: 40),
                                  decoration: const BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                  ),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Countup(
                                          begin: 0,
                                          end: totalSold.toDouble(),
                                          duration: const Duration(seconds: 2),
                                          separator: ',',
                                          prefix: 'Birr ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 24,
                                              color: Colors.white),
                                        ),
                                        const Text(
                                          "Total sold",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.8)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(
                                      top: size.height * 0.2 - 60,
                                      left: 5,
                                      right: 5),
                                  child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: soldProducts.length,
                                      itemBuilder: (c, index) =>
                                          GestureDetector(
                                            onTap: () => {
                                              Navigator.pushNamed(context,
                                                  SoldProductDetail.routeName,
                                                  arguments:
                                                      soldProducts[index])
                                            },
                                            child: TransactionItemCard(
                                                productName: soldProducts[index]
                                                    .productName,
                                                typeName: soldProducts[index]
                                                    .typeName,
                                                soldPrice: soldProducts[index]
                                                    .soldPrice,
                                                image:
                                                    soldProducts[index].image,
                                                soldAmount: soldProducts[index]
                                                    .soldAmount,
                                                date:
                                                    '${soldProducts[index].date.day}/${soldProducts[index].date.month}/${soldProducts[index].date.year}'),
                                          )),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
              }
            }
            return const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            );
          }),
    );
  }
}
