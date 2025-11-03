import '../entities/complaint.dart';

abstract class ComplaintRepository {
  Future<void> submitComplaint(ComplaintEntity complaint);
  Future<List<ComplaintEntity>> getComplaintsByTenant(String tenantId);
  Future<ComplaintEntity?> getComplaintById(String complaintId);
  Stream<List<ComplaintEntity>> watchComplaintsByTenant(String tenantId);
}
