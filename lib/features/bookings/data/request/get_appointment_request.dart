class GetAppointmentsRequest {
  final String userId;

  GetAppointmentsRequest({required this.userId});

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
    };
  }
}
