import 'package:coldroom_product_management/services/storage_management.dart';
import 'package:coldroom_product_management/ui/screens/home/home_page.dart';
import 'package:coldroom_product_management/ui/screens/login/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    chooseRoute();
  }

  chooseRoute() async {
    var token = await StorageManager.readData("token");
    if (token == null) {
      Navigator.pushReplacementNamed(context, Login.routeName);
    } else {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
