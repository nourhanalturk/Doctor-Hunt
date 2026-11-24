import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../config/constants/supabase_fields_constants.dart';
import '../../../../config/constants/supabase_tables_constants.dart';
import '../response/chat_response.dart';
import '../response/doctor_data_response.dart';

abstract class ChatsRemoteDataSource {
  Future<List<ChatResponse>> getChats();

  Future<List<DoctorDataResponse>> getDoctorsDetails(List<int> doctorIds);
}

class ChatsRemoteDataSourceImpl implements ChatsRemoteDataSource {
  static const String _allChatsTable = 'all_chats';

  final SupabaseClient client;

  ChatsRemoteDataSourceImpl(this.client);

  @override
  Future<List<ChatResponse>> getChats() async {
    final patientId = client.auth.currentUser!.id;
    final response = await client
        .from(_allChatsTable)
        .select()
        .eq(SupabaseFieldsConstants.patientId, patientId);

    return response.map((e) => ChatResponse.fromJson(e)).toList();
  }

  @override
  Future<List<DoctorDataResponse>> getDoctorsDetails(List<int> doctorIds) async {
    final response = await client
        .from(SupabaseTableConstants.homeData)
        .select()
        .filter(SupabaseFieldsConstants.id, 'in', '(${doctorIds.join(",")})');

    return response.map((e) => DoctorDataResponse.fromJson(e)).toList();
  }
}
