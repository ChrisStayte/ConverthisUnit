import 'dart:collection';
import 'dart:math';
import 'package:converthis_unit/src/constants/conversion_factors.dart';
import 'package:converthis_unit/src/constants/metric_prefix_names.dart';
import 'package:converthis_unit/src/constants/metric_prefix_values.dart';
import 'package:converthis_unit/src/constants/symbol.dart';
import 'package:converthis_unit/src/constants/unit_systems.dart';
import 'package:converthis_unit/src/enum/converter.dart';
import 'package:converthis_unit/src/enum/metric_prefix.dart';
import 'package:converthis_unit/src/enum/symbol_part.dart';
import 'package:converthis_unit/src/enum/unit_system.dart';
import 'package:converthis_unit/src/model/prefix.dart';
import 'package:converthis_unit/src/model/unit.dart';
import 'package:decimal/decimal.dart';

const variationUnitNameSeperator = '@';

/// Convert the [charcCode] to [String]
String stringFromUnicode(String charCode) =>
    String.fromCharCodes((Runes(charCode)));

/// Give an enum and string and returns the matching enum
T _enumFromString<T>(Iterable<T> values, String value) {
  return values.firstWhere(
    (type) =>
        type.toString().split('.').last.toLowerCase() == value.toLowerCase(),
  );
}

/// Create symbol from 'symbolParts'
String createSymbol(List<SymbolPart> symbolParts) {
  String symbolName = '';
  for (var part in symbolParts) {
    // {?? ''} was used because map is nullable by default
    symbolName += symbol[part] ?? '';
  }
  return symbolName;
}

/// Creates a unit with given parameters
Unit<T> createUnit<T>(
  T type,
  String name,
  List<SymbolPart> symbolParts,
  Decimal conversionFactor, {
  bool variation = false,
  UnitSystem? system,
}) {
  String symbol = createSymbol(symbolParts);
  String unitSystem = unitSystems[system] ?? '';
  return Unit<T>(name, symbol, conversionFactor, type, unitSystem);
}

// get rid of this
// Unit<T> _createUnitVariation<T>(
//   T type,
//   String namePrefix,
//   String namePostfix,
//   List<SymbolPart> symbol,
//   Decimal conversionFactor, {
//   String name = '',
//   bool variation = false,
//   UnitSystem? system,
// }) {
//   String unitName = '$namePrefix$name$namePostfix';
//   String unitSymbol = '$symbolPrefix$symbol$symbolPostfix';
//   String unitSystem = unitSystems[system] ?? '';
//   return Unit<T>(name, symbol, conversionFactor, type, unitSystem);
//}

///
/// unitEnum - list of all of the unit enums ie. TimeUnit
/// variationBaseUnitName - the unit that we want to create variations for ie. second
/// conversionFactorToBaseUnit - it's the variationbaseUnits conversion factor
/// variations - pass metric prefixes ie. decimal or binary prefixes
/// namePrefix - adding like 'square' meter
/// namePostfix - adding like 'metre per minute per second'
/// symbolPrefix - adding prefix symbols
/// symbolPostfix - regular symbols i think ahha
/// system - Unit system that this unit belongs to
/// powerOfVariationConversionFactor - comes into play for things like area
Set<Unit<T>> createUnitVariations<T>(
  Iterable<T> unitEnum,
  String variationBaseUnitName,
  Decimal conversionFactorToBaseUnit,
  List<MetricPrefix> variations, {
  String namePrefix = '',
  String namePostfix = '',
  List<SymbolPart> symbolPrefix = const [],
  List<SymbolPart> symbolPostfix = const [],
  UnitSystem? system,
  int powerOfVariationConversionFactor = 1,
}) {
  // This will be the set of units that is created
  Set<Unit<T>> units = <Unit<T>>{};

  Unit<T> varationBase = createUnit<T>(
      _enumFromString(unitEnum,
          variationBaseUnitName.replaceFirst(variationUnitNameSeperator, '')),
      '$namePrefix$namePostfix',
      [...symbolPrefix, ...symbolPostfix],
      conversionFactorToBaseUnit,
      system: system);

  units.add(varationBase);

  for (MetricPrefix p in variations) {
    String? variationName = metricPrefixNames[p];
    if (variationName == null) continue;
    Prefix? prefix = metricPrefixValues[p];
    if (prefix == null) continue;

    Decimal conversionFactor;

    // Added Big Int Capability to let larger exponets process
    // but it only works with positive numbers
    if (prefix.exponent >= 0) {
      BigInt bi = BigInt.from(prefix.base)
          .pow(powerOfVariationConversionFactor * prefix.exponent);
      conversionFactor = Decimal.fromBigInt(bi) * conversionFactorToBaseUnit;
    } else {
      Decimal di = Decimal.parse(
          pow(prefix.base, powerOfVariationConversionFactor * prefix.exponent)
              .toString());
      conversionFactor = di * conversionFactorToBaseUnit;
    }

    Unit<T> unit = createUnit<T>(
      _enumFromString(
          unitEnum,
          variationBaseUnitName.replaceFirst(
              variationUnitNameSeperator, variationName)),
      '$namePrefix$variationName$namePostfix',
      [
        ...symbolPrefix,
        _enumFromString(SymbolPart.values, variationName),
        ...symbolPostfix
      ],
      conversionFactor,
      variation: true,
      system: system,
    );

    units.add(unit);
  }
  return units;
}
