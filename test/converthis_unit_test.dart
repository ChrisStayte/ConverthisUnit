import 'package:converthis_unit/src/constants/conversion_factors.dart';
import 'package:converthis_unit/src/enum/converter.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:converthis_unit/converthis_unit.dart';

void main() {
  print(conversionFactors);

  test('adds one to input values', () {
    final calculator = Calculator();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });
}
