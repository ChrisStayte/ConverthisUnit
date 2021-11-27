import 'package:converthis_unit/src/constants/conversion_factors.dart';
import 'package:converthis_unit/src/constants/symbol.dart';
import 'package:converthis_unit/src/enum/converter.dart';
import 'package:converthis_unit/src/enum/symbol_part.dart';
import 'package:converthis_unit/src/enum/unit_system.dart';
import 'package:converthis_unit/src/model/unit.dart';
import 'package:decimal/decimal.dart';

/// Convert the [charcCode] to [String]
String stringFromUnicode(String charCode) =>
    String.fromCharCodes((Runes(charCode)));

/// Create symbole from 'symbolParts'
String createSymbol(List<SymbolPart> symbolParts) {
  String symbolName = '';
  for (var part in symbolParts) {
    // {?? ''} was used because map is nullable by default
    symbolName += symbol[part] ?? '';
  }
  return symbolName;
}

Decimal conversionFactor<T>(Converter conversionType, T unitType) {
  if (conversionFactors[conversionType] != null) {
    if (conversionFactors[conversionType]![unitType] != null) {
      return conversionFactors[conversionType]![unitType]!;
    }
  }
  // This should never be hit.
  return Decimal.fromInt(0);
}


void _addConversionFactor<T>(T unitType, Decimal conversionFactor) {
  
}

Unit<T> createUnit<T>(
  String name,
  String symbol,
  T type, {
    Decimal? conversionFactor,
    bool variation = false,
    UnitSystem? system
  }) {
    
  }
  
)
