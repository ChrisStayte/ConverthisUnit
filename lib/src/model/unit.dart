class Unit<T> {
  final String name;
  final String symbol;
  final T type;
  final bool variation;
  String? system;

  Unit(this.name, this.symbol, this.type,
      {this.variation = false, this.system});
}
