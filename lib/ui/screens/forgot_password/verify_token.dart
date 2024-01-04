import 'package:coldroom_product_management/controller/auth.dart';
import 'package:coldroom_product_management/services/storage_management.dart';
import 'package:coldroom_product_management/ui/screens/forgot_password/reset_forgot_password.dart';
import 'package:coldroom_product_management/ui/screens/login/login.dart';
import 'package:coldroom_product_management/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class VerifyToken extends StatefulWidget {
  static const String routeName = "/verify-token";
  const VerifyToken({Key? key}) : super(key: key);
  @override
  State<VerifyToken> createState() => _VerifyTokenState();
}

class _VerifyTokenState extends State<VerifyToken> {
  bool _isLoading = false;
  String _errorText = '';
  String _tokenCode = '';
  bool _isTokenRenseding = false;
  final _formKey = GlobalKey<FormState>();

  var _phoneNumber;
  _submitForm() async {
    if (_tokenCode == '') {
      return;
    }
    setState(() {
      _isLoading = true;
      _errorText = "";
    });
    try {
      Map<String, dynamic> response =
          await verifyToken(_phoneNumber, _tokenCode);
      StorageManager.saveData("token", response['token']);
      StorageManager.saveData("userId", response['id']);
      Navigator.pushReplacementNamed(context, ResetForgotPassword.routeName);
    } catch (e) {
      _errorText = e
          .toString()
          .split(':')
          .sublist(1, 2)
          .join(' ')
          .toString()
          .replaceAll('"', '');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void resendTokenCode() async {
    try {
      setState(() {
        _isTokenRenseding = true;
      });

      final response = await forgotPassword(_phoneNumber);
      const snackBar = SnackBar(
        backgroundColor: kSecondaryColor,
        content: Text(
          'Token is sent',
          style: TextStyle(color: Colors.green),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      const snackBar = SnackBar(
        backgroundColor: kSecondaryColor,
        content: Text(
          "Faild to sent token",
          style: TextStyle(color: Colors.red),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      setState(() {
        _isTokenRenseding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _phoneNumber = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 150, 30, 0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Verify Token',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kPrimaryColor),
                  )),
              const SizedBox(
                height: 10,
              ),
              OTPTextField(
                // controller: otpController,
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 45,
                style: const TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onChanged: (pin) {
                  // print("Changed:😒 " + pin);
                },
                onCompleted: (pin) {
                  _tokenCode = pin;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
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
                              "Verify",
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
                  child: _isTokenRenseding
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        )
                      : const Text(
                          'Resend',
                          style: TextStyle(color: Colors.red),
                        ),
                  onPressed: () {
                    resendTokenCode();
                  },
                ),
              ),
              Text(
                '$_errorText',
                style: const TextStyle(color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }
}
