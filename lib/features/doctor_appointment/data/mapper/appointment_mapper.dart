import 'package:tender/core/extensions/extensions.dart';
import '../../model/model/appointment_model.dart';
import '../response/appointment_response.dart';

extension AppointmentMapper on AddAppointmentResponse {
  AppointmentModel toDomain() => AppointmentModel(
    appointmentId: appointmentId.onNull(),
    doctorId: doctorId.onNull(),
    patientId: patientId.onNull(),
    appointmentTime: appointmentTime ?? DateTime.now(),
    status: status.onNull(),
    dependentName: dependentName.onNull(),
    contactNumber: contactNumber.onNull(),
    dependentImageUrl: dependentImageUrl.onNull(),
    createdAt: createdAt ?? DateTime.now(),
  );
}