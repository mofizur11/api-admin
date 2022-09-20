import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_admin/http/custom_http_request.dart';
import 'package:new_admin/screen/tab_menu.dart';
import 'package:new_admin/widget/brand_colors.dart';
import 'package:new_admin/widget/custom_TextField.dart';
import 'package:http/http.dart' as http;
import 'package:new_admin/widget/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    isLogin();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool _obscureText = true;
  bool _conobscureText = true;
  bool onProgress = false;
  String? token;
  bool isLoading = false;
  late SharedPreferences sharedPreferences;

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    if (token != null) {
      print("Not null");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return TabMenu();
      }));
    } else {
      print("Token is null");
    }
  }

  login() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        isLoading = true;
      });
      String url = "$uri/sign-in";
      var map = Map<String, dynamic>();
      map['email'] = emailController.text.toString();
      map['password'] = passwordController.text.toString();
      Uri myUri = Uri.parse(url);
      final response = await http.post(myUri,
          body: map, headers: CustomHttpRequest.defaultHeader2);
      print(response.body);
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showInToast("Login successfully");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return TabMenu();
        }));
        print("xxxxxxxxxxxxxxxxxx");
        setState(() {
          isLoading = false;
          sharedPreferences.setString("token", data['access_token']);
        });
        print("save token");
        token = sharedPreferences.getString("token");
        print('token is $token');
      } else {
        showInToast("Email & Password didn't match");
        print('Something wrongggg 201');
        print(response.body);
      }
      return "Something Wrong";
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: onProgress,
        opacity: 0.2,
        progressIndicator: CircularProgressIndicator(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            title: Text(
              'Create New Admin',
              style: TextStyle(
                  fontSize: 22,
                  color: aBlackCardColor,
                  fontWeight: FontWeight.w900),
            ),
          ),
          body: Form(
            key: _formKey,
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: 'Enter email address',
                        suffixText: "Email",
                        //  name: 'Email',
                        controller: emailController,

                        keytype: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "*Email is empty";
                          }
                          if (!value.contains('@')) {
                            return "*wrong email address";
                          } else if (!value.contains('.')) {
                            return "*wrong email address";
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        cursorColor: Colors.redAccent,
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "*Password is empty";
                          }
                          if (value.length < 6) {
                            return "*Password contants more then 6 carecters";
                          }
                          if (value.length > 20) {
                            return "*Password not contains more then 10 carecters";
                          }
                        },
                        onChanged: (v) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            gapPadding: 5.0,
                            borderSide:
                                BorderSide(color: aPrimaryColor, width: 2.5),
                          ),
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(fontSize: 14),
                          suffixIcon: passwordController.text.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                )
                              : null,
                        ),
                        obscureText: _obscureText,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: aBlackCardColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              //    getRegister(context);
                              login();
                            }

                            print('clicked');
                          },
                          child: Center(
                            child: Text(
                              'Create Account',
                              style:
                                  TextStyle(color: aPrimaryColor, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
