import 'package:coldroom_product_management/controller/auth.dart';
import 'package:coldroom_product_management/services/storage_management.dart';
import 'package:coldroom_product_management/ui/screens/login/login.dart';
import 'package:coldroom_product_management/utils/constants.dart';
import 'package:coldroom_product_management/utils/string_extensions.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  static const String routeName = '/account';
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? fname;
  String? lname;
  String? phoneNo;
  String? sex;
  String? userId;
  bool _isLoading = false;
  String _error = "";
  bool _isPhoneNoChanging = false;
  bool _isPasswordChanging = false;
  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _changePassword() async {
    try {
      var res = await changePassword(
          newPassword: _newPassword.text, oldPassword: _oldPassword.text);
      setState(() {
        _isPasswordChanging = true;
      });
      const snackBar = SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          'Your Password is changed.',
          style: TextStyle(color: Colors.green),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      var snackBar = SnackBar(
        backgroundColor: Colors.white,
        content: Text(e.toString(), style: const TextStyle(color: Colors.red)),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print("😉😉");
      print(e);
    } finally {
      _newPassword.text = "";
      _oldPassword.text = "";
      setState(() {
        _isPasswordChanging = false;
      });
      Navigator.pop(context);
    }
  }

  void _getUserData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> response = await fetchUserInfo();

      fname = response['fName'];
      lname = response['lName'];

      print('🙌');
      print(fname);
      phoneNo = response["phoneNumber"];
      sex = response["sex"];
      userId = response["id"];
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  logoutUser() async {
    await StorageManager.deleteData('token');
    await StorageManager.deleteData(('userId'));

    Navigator.of(context).pushNamedAndRemoveUntil(
        Login.routeName, (Route<dynamic> route) => false);
    await logout();
  }

  _showChangePasswordDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        insetPadding: const EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          height: 270,
          decoration: BoxDecoration(
            // color: isDark ? kDarkBlueColor : Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Old Password'),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: _oldPassword,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Old password is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('New Password'),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: _newPassword,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'New password is required';
                          } else if (value.length >= 6) {
                            return "Shouldn't be greater than 6";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _changePassword();
                            },
                            child: _isPasswordChanging
                                ? const CircularProgressIndicator()
                                : const Text("Change"),
                            style: ElevatedButton.styleFrom(
                                primary: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                          )
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAboutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('About'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.asset(
                  'assets/images/rensys.png',
                  height: 120,
                ),
                const Text(
                    "Rensys Engineering & Trading PLC is an energy solution company based in Addis Ababa.  It was established with the aim of playing its role in providing renewable energy solutions for energy-deprived communities. Since its establishment, the company has electrified millions of lives through SHS, solar mini-grid, and solar lanterns.\n\nAs energy is an enabler for socio-economic development, we give emphasis to the Productive Use of Energy. "),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: kPrimaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showContactDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Contact'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                //  |  (Toll Free) info@rensysengineering.com
                ListTile(
                  leading: Icon(Icons.phone),
                  // title: Text('Toll Free'),
                  title: Text("8544   (Toll Free)"),
                ),
                ListTile(
                  leading: Icon(Icons.call),
                  // title: Text('Phone No'),
                  title: Text("+251 952 494949"),
                ),
                ListTile(
                  leading: Icon(Icons.call),
                  // title: Text('Phone No'),
                  title: Text("+251 116 620372"),
                ),
                ListTile(
                  leading: Icon(Icons.call),
                  // title: Text('Phone No'),
                  title: Text("+251 11 6 620529"),
                ),

                ListTile(
                  leading: Icon(Icons.email),
                  // title: Text('Phone No'),
                  title: Text('info@rensysengineering.com'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: kPrimaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                color: kPrimaryColor, size: 25),
            color: Colors.black,
            onPressed: () => {Navigator.pop(context)},
          ),
        ),
        body: !_isLoading
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: size.height * .04,
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: kPrimaryColor,
                      child: Text(
                        fname?.substring(0, 1).toUpperCase() ?? '',
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${fname!.capitalize()} ${lname!.capitalize()}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: ListTile(
                        trailing: const Icon(
                          Icons.call,
                          color: kPrimaryColor,
                        ),
                        title: Text("$phoneNo"),
                        // trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    buildCard(
                        title: "Change Password",
                        onPress: _showChangePasswordDialog),
                    buildCard(title: "About", onPress: _showAboutDialog),
                    buildCard(title: "Contact us", onPress: _showContactDialog),
                    buildCard(title: "Logout", onPress: logoutUser),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
      ),
    );
  }

  Widget buildCard({title, onPress}) {
    return GestureDetector(
      onTap: onPress,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: ListTile(
          title: Text(title),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
