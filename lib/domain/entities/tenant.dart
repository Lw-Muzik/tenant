class Tenant {
  final String id;
  final String name;
  final String email;
  final String contact;
  final String address;
  final String roomNumber;
  final double monthlyRent;
  final double amountPaid;
  final double balance;
  final String property;
  final DateTime registrationDate;
  final double powerFee;
  final String? acontact;

  Tenant({
    required this.id,
    required this.name,
    required this.email,
    required this.contact,
    required this.address,
    required this.roomNumber,
    required this.monthlyRent,
    required this.amountPaid,
    required this.balance,
    required this.property,
    required this.registrationDate,
    required this.powerFee,
    this.acontact,
  });

  double getPaymentPercentage() {
    if (monthlyRent == 0) return 0;
    return (amountPaid / monthlyRent) * 100;
  }

  bool hasPowerAccess() {
    return getPaymentPercentage() >= 80 && powerFee < 5000;
  }

  double getTotalAmountPaid() {
    return amountPaid + powerFee;
  }

  bool hasOutstandingBalance() {
    return balance > 0;
  }
}
