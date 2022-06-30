import 'package:flutter/material.dart';

import '../login_sign_up/components/body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: const Body(),
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      ),
    );
  }
}
