import 'package:coldroom_product_management/controller/auth.dart';
import 'package:coldroom_product_management/services/storage_management.dart';
import 'package:coldroom_product_management/ui/screens/forgot_password/forgot_password.dart';
import 'package:coldroom_product_management/ui/screens/home/home_page.dart';
import 'package:coldroom_product_management/utils/constants.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static const String routeName = "/login";
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _ctrlPhoneNo = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  bool _isPasswordShown = false;
  final _formKey = GlobalKey<FormState>();

  String _errorText = "";
  bool _isLoading = false;

  togglePasswordHide() {
    setState(() {
      _isPasswordShown = !_isPasswordShown;
    });
  }

  submitLoginForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorText = "";
      });
    }
    try {
      Map<String, dynamic> response =
          await login(_ctrlPhoneNo.text, _ctrlPassword.text);
      StorageManager.saveData("token", response['token']);
      StorageManager.saveData("userId", response['id']);

      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } catch (e) {
      _errorText = e.toString();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/rensys.png',
                height: 150,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Coldroom Farmers Dashboard",
                  style: TextStyle(
                      fontSize: 20,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: false,
                      controller: _ctrlPhoneNo,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter phone number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(color: Colors.red)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Enter Phone No",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autofocus: false,
                      obscureText: !_isPasswordShown,
                      controller: _ctrlPassword,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          iconColor: Colors.grey,
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(color: Colors.red)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(color: Colors.red)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Enter Passsword",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          suffixIcon: IconButton(
                              color: Colors.grey,
                              onPressed: () {
                                togglePasswordHide();
                              },
                              icon: _isPasswordShown
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off))),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  submitLoginForm();
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: <Color>[
                          Color(0xff27AE60),
                          Color(0xff27AE60),
                          Color(0xff27AE60)
                        ],
                        tileMode: TileMode.mirror,
                      ),
                      borderRadius: BorderRadius.circular(25)),
                  child: Container(
                      width: MediaQuery.of(context).size.width * .9,
                      height: MediaQuery.of(context).size.height * .06,
                      alignment: Alignment.center,
                      child: _isLoading == true
                          ? const Center(
                              child: SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ))
                          : const Text(
                              "Log-in",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgotPassword.routeName);
                    },
                    child: const Text(
                      'Forgot password?',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
              ),
              Text(
                _errorText,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
