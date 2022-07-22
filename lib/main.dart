import 'package:book_hook/provider/BorrowBookProvider.dart';
import 'package:book_hook/provider/LendBookProvider.dart';
import 'package:book_hook/view/DashboardScreen.dart';
import 'package:book_hook/view/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'provider/UserProvider.dart';
import 'view/SplashScreen.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<LendBookProvider>(create: (_) => LendBookProvider()),
        ChangeNotifierProvider<BorrowBookProvider>(create: (_) => BorrowBookProvider()),
      ],
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
