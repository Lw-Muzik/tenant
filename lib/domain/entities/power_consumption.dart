class PowerConsumption {
  final String tenantId;
  final double unitsConsumed;
  final DateTime measurementDate;
  final bool isPowerOn;
  static const double powerRate = 500.0;

  PowerConsumption({
    required this.tenantId,
    required this.unitsConsumed,
    required this.measurementDate,
    required this.isPowerOn,
  });

  double calculateBill() {
    return unitsConsumed * powerRate;
  }

  bool hasExceededLimit(double maxUnits) {
    return unitsConsumed > maxUnits;
  }
}
