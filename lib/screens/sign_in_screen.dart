import 'package:audify/widgets/export_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const SignInBackground(),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: Colors
              .transparent, // need to change the sign up background with live wallpaper
          child: Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.7,
                      MediaQuery.of(context).size.height * 0.09)),
              icon: const FaIcon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              label: const Text('Sign In with Google'),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
            ),
          ),
        ),
      ],
    );
  }
}
