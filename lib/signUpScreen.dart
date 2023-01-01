import 'package:firebase_auth_1/HomeScreen.dart';
import 'package:firebase_auth_1/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/rendering/box.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(16),
        children: [
          SizedBox(
            height: 80,
          ),
          Column(
            children: [
              FlutterLogo(
                size: 55,
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Welcome",
            style: TextStyle(fontSize: 24),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: SignUpForm(),
          ),
          Expanded(
              child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    'Already here?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Get Logged in now!',
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? name;
  bool obsecureText = false;
  bool agree = false;
  final pass = new TextEditingController();

  var border =
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100)));
  var space = const SizedBox(
    height: 10,
  );
  @override
  Widget build(BuildContext context) {
    // var border = OutlineInputBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(100)));
    // var space = const SizedBox(
    //   height: 10,
    // );
    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: 'Email',
                  border: border),
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
            space,
            TextFormField(
              controller: pass,
              decoration: InputDecoration(
                  labelText: 'password',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: border,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obsecureText = !obsecureText;
                      });
                    },
                    child: Icon(
                        obsecureText ? Icons.visibility_off : Icons.visibility),
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
            space,
            TextFormField(
                decoration: InputDecoration(
                    labelText: 'Conform Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: border),
                obscureText: true,
                validator: (value) {
                  if (value != pass.text) {
                    return 'password not match';
                  }
                  return null;
                }),
            space,
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'full name',
                  prefixIcon: Icon(Icons.account_circle),
                  border: border),
              onSaved: (val) {
                name = val;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some Text';
                }
                return null;
              },
            ),
            Row(
              children: [
                Checkbox(
                    value: agree,
                    onChanged: (_) {
                      setState(() {
                        agree = !agree;
                      });
                    }),
                Flexible(
                  child: Text(
                      'By creating account, i agree to Terms & conditions and privacy policy.'),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
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
                                    builder: ((context) => HomeScreen())));
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
                )
              ],
            )
          ],
        ));
  }
}
