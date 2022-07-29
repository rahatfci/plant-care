import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant_watch/constants.dart';
import 'package:plant_watch/models/user_model.dart';
import 'package:plant_watch/screens/login_sign_up/sign_up_screen.dart';

import '../screens/home/home_screen.dart';

CollectionReference reference = FirebaseFirestore.instance.collection('users');

List<String> userType = ['admin', 'customer'];

signUpWithEmail(
    {required String email,
    required String password,
    required String name,
    required BuildContext context}) async {
  try {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      ),
    );
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await value.user!.updateDisplayName(name);
      await value.user!.updatePhotoURL(
          'https://firebasestorage.googleapis.com/v0/b/plant-watch-fci.appspot.com/o/images%2Fusers%2Favatar.png?alt=media&token=a8be1e03-03d4-48f5-b46c-3ab16e3367c2');
      await value.user!.reload();
      UserCustom userCustom = UserCustom(
          userType: userType[1],
          createdAt: Timestamp.now(),
          id: value.user!.uid,
          totalSaved: 0,
          totalOrder: 0,
          imgName: "");
      await reference
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userCustom.toJson());
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e.message!,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}

Future<void> signInWithEmail({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  try {
    showDialog(
        context: context,
        builder: (context) => const Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            )));
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e.message!,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}

signInWithGoogle(
    {bool link = false,
    AuthCredential? authCredential,
    required BuildContext context}) async {
  final GoogleSignInAccount? googleSignInAccount =
      await GoogleSignIn().signIn();

  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    try {
      showDialog(
          context: context,
          builder: (context) => const Center(
                  child: CircularProgressIndicator(
                color: kPrimaryColor,
              )));
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (link) {
        await userCredential.user!.linkWithCredential(authCredential!);
      }
      var user =
          await reference.doc(FirebaseAuth.instance.currentUser!.uid).get();
      if (!user.exists) {
        UserCustom userCustom = UserCustom(
            userType: userType[1],
            createdAt: Timestamp.now(),
            id: FirebaseAuth.instance.currentUser!.uid,
            totalSaved: 0,
            totalOrder: 0,
            imgName: "");
        reference
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(userCustom.toJson());
      }
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message!,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          backgroundColor: kPrimaryColor,
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(milliseconds: 700),
        content: Text(
          "Select an account please",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}

signInWithFacebook(BuildContext context) async {
  final LoginResult loginResult = await FacebookAuth.instance.login();
  showDialog(
      context: context,
      builder: (context) => const Center(
              child: CircularProgressIndicator(
            color: kPrimaryColor,
          )));
  final OAuthCredential credential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);

  try {
    await FirebaseAuth.instance.signInWithCredential(credential);
    var user =
        await reference.doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (!user.exists) {
      UserCustom userCustom = UserCustom(
          userType: userType[1],
          createdAt: Timestamp.now(),
          id: FirebaseAuth.instance.currentUser!.uid,
          totalSaved: 0,
          totalOrder: 0,
          imgName: "");
      reference
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userCustom.toJson());
    }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    if (e.code == 'account-exists-with-different-credential') {
      List<String> emailList =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(e.email!);
      if (emailList.first == "google.com") {
        await signInWithGoogle(
            link: true, authCredential: e.credential, context: context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "This Email is already being used",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            backgroundColor: kPrimaryColor,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message!,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          backgroundColor: kPrimaryColor,
        ),
      );
    }
  }
}

signOut(BuildContext context) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  showDialog(
      context: context,
      builder: (context) => const Center(
              child: CircularProgressIndicator(
            color: kPrimaryColor,
          )));
  try {
    final _providerData = _auth.currentUser!.providerData;
    if (_providerData.isNotEmpty) {
      if (_providerData[0].providerId.toLowerCase().contains('google')) {
        await GoogleSignIn().signOut();
      } else if (_providerData[0]
          .providerId
          .toLowerCase()
          .contains('facebook')) {
        await FacebookAuth.instance.logOut();
      }
    }

    await _auth.signOut();
    HomeScreen.selectedIndex = 0;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
        (route) => false);
  } catch (e) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e.toString(),
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}

Future<bool> isAdmin() async {
  return await (FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) {
    return value.data()!['userType'] == 'admin' ? true : false;
  }));
}
