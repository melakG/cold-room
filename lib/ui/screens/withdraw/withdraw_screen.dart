import 'package:coldroom_product_management/controller/withdraw_controller.dart';
import 'package:coldroom_product_management/models/withdraw.dart';
import 'package:coldroom_product_management/utils/constants.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'components.dart/withdraw_item_card.dart';

class WithdrawPage extends StatelessWidget {
  static const String routeName = "/withdraw";
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
          future: fetchWithdraws(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(child: Text('Faild to load data'));
              } else if (snapshot.hasData) {
                List<Withdraw> withdraws = snapshot.data as List<Withdraw>;
                if (withdraws.isEmpty) {
                  return const Center(
                    child: Text('No withdrawal yet!'),
                  );
                }
                int totalWithdraw = withdraws
                    .map((item) => item.balance)
                    .reduce((sum, item) => sum + item);

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        title: const Text(
                          "Withdraw",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        elevation: 0,
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
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
                                    end: totalWithdraw.toDouble(),
                                    duration: const Duration(seconds: 2),
                                    separator: ',',
                                    prefix: 'Birr ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        fontSize: 24),
                                  ),
                                  const Text(
                                    "Total Withdraw",
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
                                top: size.height * 0.2 - 60, left: 5, right: 5),
                            child: ListView.builder(
                                itemCount: withdraws.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    WithdrawItemCart(
                                      amount: withdraws[index].balance,
                                      date:
                                          "${withdraws[index].dateTime.day}/${withdraws[index].dateTime.month}/${withdraws[index].dateTime.year}",
                                    )),
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
