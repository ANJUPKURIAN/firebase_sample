import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/controller/login_screen_controller.dart';
import 'package:firebase_sample/controller/registration_screen_controller.dart';
import 'package:firebase_sample/view/home_screen/home_screen.dart';
import 'package:firebase_sample/view/home_screen/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

 Future<void> main() async {  
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: const FirebaseOptions(
     apiKey: "AIzaSyCUXJ1o92R5CeU6BtOxmgdlBunc_VsN_DI", 
     appId: "1:741911060197:android:6caae6e4c3130bca28be0c",
     messagingSenderId: "",
     projectId: "jansample1-2ae42",
     storageBucket: "jansample1-2ae42.appspot.com")
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
     providers: [
      ChangeNotifierProvider( create: (context) => RegistrationScreenController(),
        ),
      ChangeNotifierProvider(create: (context) => LoginScreenController(),
        )
      ],

     child: MaterialApp(
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          },
        ),   
         
      ),
    );
  }
}
