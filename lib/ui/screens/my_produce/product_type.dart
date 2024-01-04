import 'package:coldroom_product_management/controller/product_controller.dart';
import 'package:coldroom_product_management/models/product_type.dart';
import 'package:coldroom_product_management/ui/screens/my_produce/components/product_type_card.dart';
import 'package:coldroom_product_management/utils/constants.dart';
import 'package:flutter/material.dart';

class ProductTypeScreen extends StatelessWidget {
  static const String routeName = "product-type";
  const ProductTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int productId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Types'),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: FutureBuilder(
          future: fetchProductTypes(productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Faild to load data"),
                );
              } else if (snapshot.hasData) {
                List<ProductType> productTypes =
                    snapshot.data as List<ProductType>;
                return ListView.builder(
                    itemCount: productTypes.length,
                    itemBuilder: (context, index) => ProduceTypeCard(
                        image: productTypes[index].image,
                        name: productTypes[index].name,
                        remainQty: productTypes[index].remainQty,
                        soldQty: productTypes[index].soldQty,
                        addedDate: productTypes[index].addedDate));
              }
            }
            return const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            );
          }),
    );
  }
}
