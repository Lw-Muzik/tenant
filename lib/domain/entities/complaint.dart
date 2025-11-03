enum ComplaintStatus { pending, approved, rejected }

enum ComplaintType { powerSurge, plumbingIssues, maintenance, others }

class ComplaintEntity {
  final String id;
  final String tenantId;
  final String propertyId;
  final String title;
  final String description;
  final ComplaintType type;
  final ComplaintStatus status;
  final DateTime submissionDate;
  final String? image;
  final String? reason;

  ComplaintEntity({
    required this.id,
    required this.tenantId,
    required this.propertyId,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.submissionDate,
    this.image,
    this.reason,
  });

  bool isPending() {
    return status == ComplaintStatus.pending;
  }

  bool isResolved() {
    return status == ComplaintStatus.approved ||
        status == ComplaintStatus.rejected;
  }

  String getStatusDisplayText() {
    switch (status) {
      case ComplaintStatus.pending:
        return 'Pending';
      case ComplaintStatus.approved:
        return 'Approved';
      case ComplaintStatus.rejected:
        return 'Rejected';
    }
  }
}
