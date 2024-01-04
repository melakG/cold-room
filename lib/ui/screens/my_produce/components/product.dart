import 'package:coldroom_product_management/models/product.dart';
import 'package:coldroom_product_management/ui/screens/my_produce/product_type.dart';
import 'package:coldroom_product_management/utils/string_extensions.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.myProduct,
  }) : super(key: key);

  final Product myProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, ProductTypeScreen.routeName,
              arguments: myProduct.id);
        },
        textColor: Colors.black,

        leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              myProduct.image,
              width: 80,
              fit: BoxFit.cover,
            )),
        title: Text(
          myProduct.name.capitalize(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          '${myProduct.remainingQty} Kg',
          style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5)),
        ),
        trailing: Text(
          " ${myProduct.createdAt.day}/${myProduct.createdAt.month}/${myProduct.createdAt.year}",
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
