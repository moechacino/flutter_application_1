import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/screens/member_home.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Aplikasi PJMK"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image(
                    image: AssetImage("assets/images/logo-pens.png"),
                    height: size.height * 0.3,
                  ),
                ),
                Form(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            labelText: "Email",
                            hintText: "Email",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline_rounded),
                            labelText: "Password",
                            hintText: "Password",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              String email = emailController.text;
                              String password = passwordController.text;
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: email,
                                password: password,
                              )
                                  .then((value) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MemberHome(),
                                  ),
                                );
                              }).catchError((error) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Login Gagal'),
                                      content:
                                          Text('Email atau Password salah'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              });
                            },
                            child: Text("LOGIN"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
