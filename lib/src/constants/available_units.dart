import 'package:converthis_unit/src/constants/unit_details/time_unit_details.dart';
import 'package:converthis_unit/src/enum/converter.dart';
import 'package:converthis_unit/src/model/unit.dart';

final Map<Converter, Set<Unit>> availableUnits = {
  Converter.time: timeUnitDetails,
};
