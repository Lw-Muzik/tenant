import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/tenant.dart';
import '../../domain/repositories/tenant_repository.dart';

class FirebaseTenantRepository implements TenantRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Tenant?> getTenantById(String tenantId) async {
    try {
      final doc = await _firestore.collection('tenants').doc(tenantId).get();
      if (!doc.exists) return null;

      final data = doc.data()!;
      return Tenant(
        id: tenantId,
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        contact: data['contact'] ?? '',
        address: data['address'] ?? '',
        roomNumber: data['roomNumber'] ?? '',
        monthlyRent: double.parse(data['monthlyRent'] ?? '0'),
        amountPaid: double.parse(data['amountPaid'] ?? '0'),
        balance: double.parse(data['balance'] ?? '0'),
        property: data['property'] ?? '',
        registrationDate: DateTime.parse(
          data['date'] ?? DateTime.now().toString(),
        ),
        powerFee: double.parse(data['power_fee'] ?? '0'),
        acontact: data['acontact'],
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateTenantPayment(
    String tenantId,
    double rentAmount,
    double electricityAmount,
  ) async {
    final tenant = await getTenantById(tenantId);
    if (tenant == null) return;

    await _firestore.collection('tenants').doc(tenantId).update({
      'amountPaid': (tenant.amountPaid + rentAmount).toString(),
      'balance': (tenant.balance - rentAmount).toString(),
      'power_fee': (tenant.powerFee - electricityAmount).toString(),
    });
  }

  @override
  Future<List<Tenant>> getAllTenants() async {
    final snapshot = await _firestore.collection('tenants').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Tenant(
        id: doc.id,
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        contact: data['contact'] ?? '',
        address: data['address'] ?? '',
        roomNumber: data['roomNumber'] ?? '',
        monthlyRent: double.parse(data['monthlyRent'] ?? '0'),
        amountPaid: double.parse(data['amountPaid'] ?? '0'),
        balance: double.parse(data['balance'] ?? '0'),
        property: data['property'] ?? '',
        registrationDate: DateTime.parse(
          data['date'] ?? DateTime.now().toString(),
        ),
        powerFee: double.parse(data['power_fee'] ?? '0'),
        acontact: data['acontact'],
      );
    }).toList();
  }
}
