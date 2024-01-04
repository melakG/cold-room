import 'package:coldroom_product_management/services/api_base_helper.dart';
import 'package:coldroom_product_management/services/storage_management.dart';

ApiBaseHelper apiBaseHelper = ApiBaseHelper();

Future<Map<String, dynamic>> login(phoneNo, password) async {
  final response = await apiBaseHelper.post(
      url: '/farmer/auth/login',
      payload: {"phoneNumber": phoneNo, "password": password});

  return response;
}

Future<Map<String, dynamic>> fetchUserInfo() async {
  var token = await StorageManager.readData("token");
  var id = await StorageManager.readData("userId");
  final response =
      await apiBaseHelper.get(url: '/farmer/farmerProfile/${id}', token: token);

  return response;
}

Future logout() async {
  await StorageManager.deleteData("token");
  await StorageManager.deleteData("userId");
  await apiBaseHelper.get(url: '/farmer/auth/logout');
}

Future forgotPassword(phoneNumber) async {
  final response = await apiBaseHelper.get(
    url: '/farmer/farmers/forgotPassword/$phoneNumber',
  );

  return response;
}

Future verifyToken(phoneNumber, token) async {
  final response = await apiBaseHelper.post(
    url: '/farmer/farmers/verifyToken/$phoneNumber',
    payload: {"tokenCode":token}
  );
  return response;
}

Future changePassword({oldPassword, newPassword}) async {
  var id = await StorageManager.readData("userId");
  var token = await StorageManager.readData("token");
      
  final response = await apiBaseHelper.put(
      url: '/farmer/farmerProfile/password/${id}',
      payload: {"oldPassword": oldPassword, 'newPassword': newPassword},
      token: token);

  return response;
}

Future resetForgotPassword({password}) async {
  var id = await StorageManager.readData("userId");
  var token = await StorageManager.readData("token");

  final response = await apiBaseHelper.post(
      url: '/farmer/farmers/resetPassword/$id',
      payload: {"newPassword": password},
      token: token);

  return response;
}
