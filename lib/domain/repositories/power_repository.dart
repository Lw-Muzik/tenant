import '../entities/power_consumption.dart';

abstract class PowerRepository {
  Future<PowerConsumption?> getCurrentPowerStatus(String tenantId);
  Future<void> controlPower(String tenantId, bool turnOn);
  Future<double> getPowerConsumed(String tenantId);
}
