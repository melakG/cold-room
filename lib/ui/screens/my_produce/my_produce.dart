import 'package:coldroom_product_management/controller/product_controller.dart';
import 'package:coldroom_product_management/models/product.dart';
import 'package:coldroom_product_management/utils/constants.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'components/product.dart';

class MyProduce extends StatelessWidget {
  static const String routeName = "/my-product";
  MyProduce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
          future: fetchProducts(),
          builder: (context, snapshoot) {
            if (snapshoot.connectionState == ConnectionState.done) {
              if (snapshoot.hasError) {
                return const Center(
                  child: Text("Faild to load data"),
                );
              } else if (snapshoot.hasData) {
                List myProducts = snapshoot.data as List<Product>;
                double totalProduce = myProducts.fold(0, (t, item) {
                  return item.remainingQty.toDouble() + t;
                });
                return SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: [
                      AppBar(
                        leading: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon:
                                const Icon(Icons.arrow_back_ios_new_outlined)),
                        title: const Text(
                          "My Produce",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        elevation: 0,
                      ),

                      Stack(
                        children: [
                          Container(
                            height: size.height * 0.2,
                            padding: const EdgeInsets.only(bottom: 40),
                            decoration: const BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                            ),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Countup(
                                    begin: 0,
                                    end: totalProduce,
                                    duration: const Duration(seconds: 2),
                                    separator: ',',
                                    suffix: ' KG',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        fontSize: 24),
                                  ),
                                  const Text(
                                    "Total Produce",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.8)),
                                  ),
                                ],
                              ), 
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: size.height * 0.2 - 60, right: 5, left: 5),
                            child: ListView.builder(
                                itemCount: myProducts.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ProductCard(
                                      myProduct: myProducts[index]);
                                }),
                          ),
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
