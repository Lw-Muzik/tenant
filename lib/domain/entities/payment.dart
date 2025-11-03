class PaymentEntity {
  final String id;
  final String tenantId;
  final String tenantName;
  final double amount;
  final double balance;
  final String property;
  final DateTime date;
  final String paymentMode;
  final String status;
  final double electricityBill;

  PaymentEntity({
    required this.id,
    required this.tenantId,
    required this.tenantName,
    required this.amount,
    required this.balance,
    required this.property,
    required this.date,
    required this.paymentMode,
    required this.status,
    required this.electricityBill,
  });

  bool isSuccessful() {
    return status.toLowerCase() == 'success';
  }

  bool isToday() {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
