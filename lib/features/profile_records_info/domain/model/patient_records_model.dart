class PatientRecordsModel {
  String? diseaseName;
  String? description;
  String? doctorName;
  dynamic? reportDate;
  String? medicineNames;
  List<dynamic>? imageUrls;
  String? recordFor;

  PatientRecordsModel({
    this.diseaseName,
    this.description,
    this.doctorName,
    this.reportDate,
    this.medicineNames,
    this.imageUrls,
    this.recordFor,
  });
}
