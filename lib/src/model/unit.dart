import 'package:converthis_unit/src/enum/unit_system.dart';
import 'package:decimal/decimal.dart';

class Unit<T> {
  final String name;
  final String symbol;
  final Decimal conversionFactor;
  final T type;
  final bool variation;
  UnitSystem? unitSystem;
  Unit(this.name, this.symbol, this.conversionFactor, this.type,
      {this.variation = false, this.unitSystem});
}
