import 'package:coldroom_product_management/controller/auth.dart';
import 'package:coldroom_product_management/ui/screens/forgot_password/verify_token.dart';
import 'package:coldroom_product_management/ui/screens/login/login.dart';
import 'package:coldroom_product_management/utils/constants.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  static const String routeName = "/forgot-password";
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _isLoading = false;
  String _errorText = '';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlPhoneNo = TextEditingController();

  _submitLoginForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorText = "";
      });

      try {
        final response = await forgotPassword(_ctrlPhoneNo.text);
        Navigator.pushNamed(context, VerifyToken.routeName,
            arguments: _ctrlPhoneNo.text);
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
                    'Forgot Password',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kPrimaryColor),
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                autofocus: false,
                // style: const TextStyle(color: Colors.white),
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
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "Enter Phone No",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _submitLoginForm();
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
                              "Send",
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
                      Navigator.pushNamed(context, Login.routeName);
                    },
                    child: const Text(
                      'Login ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
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
