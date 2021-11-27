import 'package:converthis_unit/src/enum/converter.dart';

extension CapExtension on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
  String get capitalizeAll => toUpperCase();
  String get capitalizeFirstOfEach =>
      split(" ").map((str) => str.capitalize).join(" ");
}
