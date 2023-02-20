import 'package:audify/screens/export_screens.dart';
import 'package:audify/widgets/export_widgets.dart';
import 'package:audify/service/http_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  // Disable Screen Rotation
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Initialize Firebase
  await Firebase.initializeApp();
  await initialization(null);
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 3));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Audify',
        theme: ThemeData(
          primaryColor: Colors.black,
          splashColor: Colors.black,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme.apply(
                  bodyColor: Colors.grey.shade100,
                  displayColor: Colors.grey.shade100,
                ),
          ),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Colors.green.shade600)
              .copyWith(background: Colors.black),
        ),
        home: FutureBuilder(
          future: HttpService().getAllSongs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.green.shade600,
              ));
            } else if (snapshot.hasData) {
              return const AuthScreen();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Something went wrong!',
                  style: TextStyle(color: Colors.black),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'Something went wrong!',
                  style: TextStyle(color: Colors.black),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}