import 'package:coldroom_product_management/controller/auth.dart';
import 'package:coldroom_product_management/services/storage_management.dart';
import 'package:coldroom_product_management/ui/screens/forgot_password/forgot_password.dart';
import 'package:coldroom_product_management/ui/screens/home/home_page.dart';
import 'package:coldroom_product_management/utils/constants.dart';
import 'package:flutter/material.dart';

class ResetForgotPassword extends StatefulWidget {
  static const String routeName = "/reset-forgot-password";
  const ResetForgotPassword({Key? key}) : super(key: key);

  @override
  State<ResetForgotPassword> createState() => _ResetForgotPasswordState();
}

class _ResetForgotPasswordState extends State<ResetForgotPassword> {
  final TextEditingController _ctrlPassword = TextEditingController();
  final TextEditingController _ctrlConfirmPassword = TextEditingController();
  bool _isPasswordShown = false;
  bool _isConfirmPasswordShown = false;
  final _formKey = GlobalKey<FormState>();

  String _errorText = "";
  bool _isLoading = false;

  submitResetForgotPasswordForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorText = "";
      });

      try {
        Map<String, dynamic> response =
            await resetForgotPassword(password: _ctrlPassword.text);
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomePage.routeName, (Route<dynamic> route) => false);
        // Navigator.pushReplacementNamed(context, HomePage.routeName);
      } catch (e) {
        _errorText = e.toString();
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 150, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Set New Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: false,
                      // style: const TextStyle(color: Colors.white),
                      controller: _ctrlPassword,
                      obscureText: !_isPasswordShown,
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
                        suffixIcon: IconButton(
                            color: Colors.grey,
                            onPressed: () {
                              setState(() {
                                _isPasswordShown = !_isPasswordShown;
                              });
                            },
                            icon: _isPasswordShown
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "New Password",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autofocus: false,
                      obscureText: !_isConfirmPasswordShown,
                      // style: const TextStyle(color: Colors.black),
                      controller: _ctrlConfirmPassword,
                      // keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Password';
                        }
                        if (value != _ctrlPassword.text) {
                          return "Password don't match";
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
                        suffixIcon: IconButton(
                            color: Colors.grey,
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordShown =
                                    !_isConfirmPasswordShown;
                              });
                            },
                            icon: _isConfirmPasswordShown
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
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
                        hintText: "Confirm Passsword",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  submitResetForgotPasswordForm();
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
                              "Change Password",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                ),
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
