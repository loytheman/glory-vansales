// ignore_for_file: camel_case_types
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class wCountryFlag extends StatelessWidget {
  final String? countryCode;

  const wCountryFlag({super.key, required this.countryCode});

  @override
  Widget build(BuildContext context) {
    String code = countryCode ?? "SG";

    final w = Container(
      width: 24,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: CountryFlag.fromCountryCode(code.toUpperCase()),
    );

    return w;
  }
}
