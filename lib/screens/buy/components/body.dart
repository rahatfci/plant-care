import 'package:flutter/material.dart';
import 'package:plant_watch/authentication/form_validation.dart';
import 'package:plant_watch/components/form_field.dart';
import 'package:plant_watch/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController nameAdd = TextEditingController();
  TextEditingController phoneAdd = TextEditingController();
  TextEditingController emailAdd = TextEditingController();
  TextEditingController addressAdd = TextEditingController();
  TextEditingController districtAdd = TextEditingController();
  TextEditingController noteAdd = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Information for Order",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    formField(nameAdd, "Name", TextInputType.name,
                        (value) => productNameValidator(value)),
                    const SizedBox(
                      height: 15,
                    ),
                    formField(phoneAdd, "Phone", TextInputType.phone,
                        (value) => phoneNumberValidator(value)),
                    const SizedBox(
                      height: 15,
                    ),
                    formField(
                        emailAdd,
                        "Email (Optional)",
                        TextInputType.emailAddress,
                        (value) => noValidation(value)),
                    const SizedBox(
                      height: 15,
                    ),
                    formField(addressAdd, "Address", TextInputType.text,
                        (value) => productDescriptionValidator(value)),
                    const SizedBox(
                      height: 15,
                    ),
                    formField(districtAdd, "District", TextInputType.text,
                        (value) => productNameValidator(value)),
                    const SizedBox(
                      height: 15,
                    ),
                    formField(noteAdd, "Note (Optional)", TextInputType.text,
                        (value) => noValidation(value)),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    "Back",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
                Container(
                  width: 2,
                  height: 20,
                  color: Colors.white,
                ),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      FocusManager.instance.primaryFocus!.unfocus();
                      Navigator.pushNamed(
                        context,
                        '/confirm_order',
                        arguments: <String>[
                          addressAdd.text,
                          noteAdd.text,
                          phoneAdd.text
                        ],
                      );
                    }
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
