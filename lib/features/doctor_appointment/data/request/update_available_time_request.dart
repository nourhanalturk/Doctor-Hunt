class UpdateAvailableTimeRequest {
  final int doctorId;
  final String date;
  final String timeToRemove;

  const UpdateAvailableTimeRequest({
    required this.doctorId,
    required this.date,
    required this.timeToRemove,
  });
}
