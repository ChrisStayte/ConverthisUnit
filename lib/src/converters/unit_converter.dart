import 'package:converthis_unit/src/constants/available_units.dart';
import 'package:converthis_unit/src/constants/base_units.dart';
import 'package:converthis_unit/src/enum/converter.dart';
import 'package:converthis_unit/src/global/functions.dart';
import 'package:converthis_unit/src/model/unit.dart';
import 'package:decimal/decimal.dart';

class UnitConverter<T> {
  /// The type of converter that is created
  final Converter _type;

  /// The base unit for the converter derived from the type
  final T _baseUnit;

  /// Total number of units in this converter
  int get unitCount => _availableUnits().length;

  /// The base unit of this converter
  Unit<T> get baseUnit => unit(_baseUnit);

  UnitConverter(this._type) : _baseUnit = baseUnits[_type] as T {}

  Decimal convert({required Decimal value, required T from, required T to}) {
    if (from != to) {
      switch (_type) {
        default:
          final fromOffset = conversionFactor(_type, from);
          final toOffset = conversionFactor(_type, to);
          value *= fromOffset;
          value /= toOffset;
          return value;
      }
    }
    return value;
  }

  Set<Unit<T>> _availableUnits() {
    return availableUnits[_type] as Set<Unit<T>>;
  }

  /// Returns the unit matching the type
  Unit<T> unit(T type) =>
      _availableUnits().firstWhere((unit) => unit.type == type);

  Set<Unit<T>> units(
      {Set<T>? include, Set<T>? exclude, bool withoutVariation = false}) {
    var units = _availableUnits();
    if (withoutVariation) {
      units = units.where((unit) => unit.variation == false).toSet();
    }
    return _filterUnits(units, include, exclude);
  }

  Set<Unit<T>> _filterUnits(
      Set<Unit<T>> units, Set<T>? include, Set<T>? exclude) {
    if (include != null) {
      return units.where((unit) => include.contains(unit.type)).toSet();
    }
    if (exclude != null) {
      return units.where((unit) => !exclude.contains(unit.type)).toSet();
    }
    return units;
  }
}
