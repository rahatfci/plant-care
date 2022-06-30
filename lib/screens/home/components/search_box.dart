import 'package:flutter/material.dart';

import '../../../constants.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final searchKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        style: const TextStyle(
          color: kTextColor,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        key: searchKey,
        controller: searchController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          hintText: "Search Plants...",
          hintStyle: const TextStyle(
            color: kTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: kPrimaryColor)),
          //suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
        ),
      ),
    );
  }
}
