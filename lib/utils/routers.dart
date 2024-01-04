
import 'package:coldroom_product_management/ui/screens/account/account.dart';
import 'package:coldroom_product_management/ui/screens/forgot_password/forgot_password.dart';
import 'package:coldroom_product_management/ui/screens/forgot_password/reset_forgot_password.dart';
import 'package:coldroom_product_management/ui/screens/forgot_password/verify_token.dart';
import 'package:coldroom_product_management/ui/screens/home/home_page.dart';
import 'package:coldroom_product_management/ui/screens/login/login.dart';
import 'package:coldroom_product_management/ui/screens/my_produce/my_produce.dart';
import 'package:coldroom_product_management/ui/screens/my_produce/product_type.dart';
import 'package:coldroom_product_management/ui/screens/sold_produce/sold_produce.dart';
import 'package:coldroom_product_management/ui/screens/sold_produce/sold_product_detail.dart';
import 'package:coldroom_product_management/ui/screens/withdraw/withdraw_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  HomePage.routeName: ((context) => const HomePage()),
  MyProduce.routeName: ((context) => MyProduce()),
  SoldProduce.routeName: (context) => const SoldProduce(),
  WithdrawPage.routeName: (context) => const WithdrawPage(),
  Login.routeName: (context) => const Login(),
  Account.routeName: (context) => const Account(),
  SoldProductDetail.routeName: (context) => const SoldProductDetail(),
  ProductTypeScreen.routeName: (context) => const ProductTypeScreen(),
  ForgotPassword.routeName: (context) => const ForgotPassword(),
  VerifyToken.routeName: (context)=>const VerifyToken(),
  ResetForgotPassword.routeName: (context) => const ResetForgotPassword()
};
 