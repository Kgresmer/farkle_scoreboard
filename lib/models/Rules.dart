import 'package:flutter/material.dart';


class Rules {
  bool farkleRule;
  bool onesRule;
  bool entryPoint300;
  bool entryPoint400;
  bool entryPoint500;

  Rules(
      @required this.farkleRule,
      @required this.onesRule,
      @required this.entryPoint300,
      @required this.entryPoint400,
      @required this.entryPoint500
      ) {}

  Map toJson() => {
  'farkleRule': farkleRule,
  'onesRule': onesRule,
  'entryPoint300': entryPoint300,
  'entryPoint400': entryPoint400,
  'entryPoint500': entryPoint500
  };

  Rules.load(this.farkleRule,
      this.onesRule,
      this.entryPoint300,
      this.entryPoint400,
      this.entryPoint500
      );

  factory Rules.fromJsonMap(dynamic data) {
    return Rules.load(data['farkleRule'],
        data['onesRule'],
        data['entryPoint300'],
        data['entryPoint400'],
        data['entryPoint500']);
  }

}