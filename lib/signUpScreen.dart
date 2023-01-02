import 'package:firebase_auth_1/HomeScreen.dart';
import 'package:firebase_auth_1/authentication.dart';
import 'package:firebase_auth_1/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/rendering/box.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? name;
  bool obsecureText = false;
  bool agree = false;
  final pass = new TextEditingController();
  final email_ctrl = new TextEditingController();

  var border =
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100)));
  var space = const SizedBox(
    height: 10,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: Container(
            width: 300,
            height: 600,
            color: Colors.yellow,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: FlutterLogo(
                    size: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 20),
                  child: TextFormField(
                    controller: email_ctrl,
                    decoration: InputDecoration(labelText: "email"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some Text';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      email = val;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: TextFormField(
                    controller: pass,
                    decoration: InputDecoration(
                        labelText: 'password',
                        prefixIcon: Icon(Icons.lock_outline),
                        // border: border,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obsecureText = !obsecureText;
                            });
                          },
                          child: Icon(obsecureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        )),
                    onSaved: (val) {
                      password = val;
                    },
                    obscureText: !obsecureText,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Conform Password',
                        prefixIcon: Icon(Icons.lock_outline),
                        // border: border
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value != pass.text) {
                          return 'password not match';
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'full name',
                      prefixIcon: Icon(Icons.account_circle),
                      //border: border
                    ),
                    onSaved: (val) {
                      name = val;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        AuthenticationHelper()
                            .signUp(email: email!, password: password!)
                            .then((result) {
                          if (result == null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              result,
                              style: TextStyle(fontSize: 16),
                            )));
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24)))),
                    child: Text('SignUp'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("already have an account"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text('CLick Here'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildLogo() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.blue),
      child: Center(
          child: Text(
        'I',
        style: TextStyle(fontSize: 60, color: Colors.white),
      )),
    );
  }
}
