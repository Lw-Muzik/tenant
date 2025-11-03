import '../../domain/entities/complaint.dart';
import '../../domain/repositories/complaint_repository.dart';

class SubmitComplaintUseCase {
  final ComplaintRepository _complaintRepository;

  SubmitComplaintUseCase(this._complaintRepository);

  Future<void> execute({
    required String tenantId,
    required String propertyId,
    required String title,
    required String description,
    required ComplaintType type,
    String? image,
  }) async {
    final complaint = ComplaintEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      tenantId: tenantId,
      propertyId: propertyId,
      title: title,
      description: description,
      type: type,
      status: ComplaintStatus.pending,
      submissionDate: DateTime.now(),
      image: image,
    );

    await _complaintRepository.submitComplaint(complaint);
  }
}
