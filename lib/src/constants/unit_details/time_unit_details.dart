import 'package:converthis_unit/src/constants/decimal_prefixes.dart';
import 'package:converthis_unit/src/enum/symbol_part.dart';
import 'package:converthis_unit/src/enum/unit_system.dart';
import 'package:converthis_unit/src/enum/units/time_unit.dart';
import 'package:converthis_unit/src/global/functions.dart';
import 'package:converthis_unit/src/model/unit.dart';
import 'package:decimal/decimal.dart';

final Set<Unit> _secondVariations = createUnitVariations<TimeUnit>(
    TimeUnit.values,
    '${variationUnitNameSeperator}second',
    Decimal.fromInt(1),
    decimalPrefixes,
    namePostfix: 'second',
    symbolPostfix: const [SymbolPart.second]);

final Set<Unit> _otherUnits = {
  createUnit<TimeUnit>(
    TimeUnit.century,
    'century',
    const [SymbolPart.century],
    Decimal.fromInt(100),
  ),
  createUnit<TimeUnit>(
    TimeUnit.day,
    'day',
    const [SymbolPart.day],
    Decimal.fromInt(86400),
  ),
  createUnit<TimeUnit>(
    TimeUnit.decade,
    'decade',
    const [SymbolPart.decade],
    Decimal.fromInt(315360000),
  ),
  createUnit<TimeUnit>(
    TimeUnit.fortnight,
    'fortnight',
    const [SymbolPart.fortnight],
    Decimal.fromInt(1209600),
  ),
  createUnit<TimeUnit>(
    TimeUnit.hour,
    'hour',
    const [SymbolPart.hour],
    Decimal.fromInt(3600),
  ),
  createUnit<TimeUnit>(
    TimeUnit.millennium,
    'millennium',
    const [SymbolPart.millennium],
    Decimal.fromInt(1000),
    system: UnitSystem.gregorian,
  ),
  createUnit<TimeUnit>(
    TimeUnit.minute,
    'minute',
    const [SymbolPart.minute],
    Decimal.fromInt(60),
  ),
  createUnit<TimeUnit>(
    TimeUnit.month,
    'month',
    const [SymbolPart.month],
    Decimal.fromInt(2628000),
    system: UnitSystem.gregorian,
  ),
  createUnit<TimeUnit>(
    TimeUnit.week,
    'week',
    const [SymbolPart.week],
    Decimal.fromInt(604800),
  ),
  createUnit<TimeUnit>(
    TimeUnit.year,
    'year',
    const [SymbolPart.year],
    Decimal.fromInt(31556952),
    system: UnitSystem.gregorian,
  ),
};

final Set<Unit> timeUnitDetails = {
  ..._secondVariations,
  ..._otherUnits,
};
