import 'dart:convert';

import 'package:converthis_unit/src/constants/conversion_factors.dart';
import 'package:converthis_unit/src/converters/unit_converter.dart';
import 'package:converthis_unit/src/enum/converter.dart';
import 'package:converthis_unit/src/enum/units/time_unit.dart';
import 'package:converthis_unit/src/model/unit.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:converthis_unit/converthis_unit.dart';

void main() {
  UnitConverter converter = UnitConverter<TimeUnit>(Converter.time);

  print(converter.convert(
      from: TimeUnit.minute, to: TimeUnit.second, value: Decimal.fromInt(1)));
  test('adds one to input values', () {
    final calculator = Calculator();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });
}
