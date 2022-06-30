import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/authentication/form_validation.dart';
import 'package:plant_watch/constants.dart';
import 'package:plant_watch/screens/login_sign_up/components/bottom_text.dart';
import 'package:plant_watch/screens/login_sign_up/components/form_design.dart';
import 'package:plant_watch/screens/login_sign_up/components/login_signup_select.dart';

import '../../../authentication/auth.dart';
import 'input_field.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  static bool signup = false;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        topStyle(context),
        welcomeText(),
        Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin:
              const EdgeInsets.only(left: 15, right: 15, top: 140, bottom: 8),
          shadowColor: Colors.black87,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    loginSignUpSelect(setState),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Body.signup == true
                        ? TextInputField(
                            textInputType: TextInputType.name,
                            textEditingController: name,
                            label: "Name",
                            validator: (value) =>
                                nameValidator(value, Body.signup),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 15,
                    ),
                    TextInputField(
                        textInputType: TextInputType.emailAddress,
                        textEditingController: email,
                        label: "Email",
                        validator: (value) => emailValidator(value)),
                    const SizedBox(
                      height: 15,
                    ),
                    TextInputField(
                        textInputType: TextInputType.visiblePassword,
                        textEditingController: password,
                        label: "Password",
                        validator: (value) => passwordValidator(value),
                        isPass: true),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (Body.signup == true) {
                              await signUpWithEmail(
                                  name: name.text.trim(),
                                  email: email.text.trim(),
                                  password: password.text.trim(),
                                  context: context);
                            } else {
                              FocusManager.instance.primaryFocus!.unfocus();
                              await signInWithEmail(
                                  email: email.text.trim(),
                                  password: password.text.trim(),
                                  context: context);
                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Submit",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 25,
                    ),
                    Center(child: orDivider(context)),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      child: gLogin(text: "Continue with Google"),
                      onTap: () async {
                        await signInWithGoogle(context: context);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                        child: fbLogin(text: "Continue with Facebook"),
                        onTap: () async {
                          await signInWithFacebook(context);
                        }),
                    const SizedBox(
                      height: 13,
                    ),
                    bottomText()
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
