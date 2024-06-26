import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/controller/registration_screen_controller.dart';
import 'package:firebase_sample/view/home_screen/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
 TextEditingController emailController = TextEditingController(); // text on textfield
  TextEditingController passController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    final providerobj = context.watch<RegistrationScreenController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Regiater Now",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Email",
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Password",
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            providerobj.isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      if (emailController.text.isNotEmpty &&
                          passController.text.isNotEmpty) {
                        // registration funciton
                        context
                            .read<RegistrationScreenController>()
                            .register(
                                context: context,
                                email: emailController.text,
                                password: passController.text)
                            .then((value) {
                          if (value == true) {
                            // login success
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                content: Text("Registration Success")));
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                                (route) => false);
                          } else {
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //     backgroundColor: Colors.red,
                            //     content: Text("Registration Failed")));
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Enter a valid email and password")));
                      }
                    },
                    child: Text("Register")),
            SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Already have account"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    },
                    child: Text("Login now")),
              ],
            )
          ],
        ),
      ),
    );
  }
} 