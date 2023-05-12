import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'register_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/logo-pens.png',
              width: 300,
              height: height * 0.6,
            ),
            Column(
              children: [
                Text(
                  "APLIKASI PJMK",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                  onPressed: () => Get.to(() => const LoginScreen()),
                  child: Text("LOGIN"),
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(),
                      foregroundColor: Color.fromARGB(255, 255, 255, 255),
                      side: BorderSide(color: Color(0xFFF2D619)),
                      backgroundColor: Color(0xFFF2D619),
                      padding: EdgeInsets.symmetric(vertical: 20)),
                )),
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () => Get.to(() => const RegisterScreen()),
                        child: Text("REGISTER"),
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(),
                            foregroundColor: Color(0xFFFFFFFF),
                            backgroundColor: Color(0xFF0B2D94),
                            side: BorderSide(color: Color(0xFF0B2D94)),
                            padding: EdgeInsets.symmetric(vertical: 20))))
              ],
            )
          ],
        ),
      ),
    );
  }
}
