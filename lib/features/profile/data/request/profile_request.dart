import 'package:easy_localization/easy_localization.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';

class ProfileRequest {
  String userId;
  String imageUrl;

  String name;

  String contactNumber;

  DateTime dateOfBirth;

  String location;

  ProfileRequest({
    required this.userId,
    required this.imageUrl,
    required this.name,
    required this.contactNumber,
    required this.location,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toJson()=> {
    SupabaseFieldsConstants.userId : userId ,
    SupabaseFieldsConstants.name : name ,
    SupabaseFieldsConstants.contactNumber :contactNumber ,
    SupabaseFieldsConstants.dateOfBirth : DateFormat('yyyy-MM-dd').format(dateOfBirth) ,
    SupabaseFieldsConstants.location : location ,
    SupabaseFieldsConstants.imageUrl : imageUrl ,
  };
}
