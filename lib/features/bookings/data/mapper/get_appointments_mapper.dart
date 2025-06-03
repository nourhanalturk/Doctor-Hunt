import '../../../doctor_appointment/domain/model/appointment_model.dart';
import '../response/get_appointments_response.dart';
import 'package:tender/core/extensions/extensions.dart';

extension GetAppointmentsMapper on GetAppointmentsResponse {
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
