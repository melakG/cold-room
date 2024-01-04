import 'package:coldroom_product_management/models/product.dart';
import 'package:coldroom_product_management/models/product_type.dart';
import 'package:coldroom_product_management/services/api_base_helper.dart';
import 'package:coldroom_product_management/services/storage_management.dart';

ApiBaseHelper apiBaseHelper = ApiBaseHelper();

Future<List<Product>> fetchProducts() async {
  var id = await StorageManager.readData("userId");
  var token = await StorageManager.readData("token");
  List<Product> products = [];
  final response = await apiBaseHelper.get(
      url: '/farmer/farmerHome/farmerProduct/$id', token: token);
  List productResponse = response as List;
  for (int i = 0; i < productResponse.length; i++) {
    Map<String, dynamic> map = productResponse[i];
    products.add(Product.fromJson(map));
  }
  return products;
}

Future<List<ProductType>> fetchProductTypes( productId) async {
  int id = await StorageManager.readData("userId");
  String token = await StorageManager.readData("token");
  List<ProductType> productTypes = [];
  final response = await apiBaseHelper.post(
      url: '/farmer/farmerHome/productType/$id',
      payload: {"productId": productId},
      token: token);
  List productTypeResponse = response as List;
  for (int i = 0; i < productTypeResponse.length; i++) {
    Map<String, dynamic> map = productTypeResponse[i];
    productTypes.add(ProductType.fromJson(map));
  }
  return productTypes;
}
