import 'package:dio/dio.dart';
import 'package:stadium_eye/core/networking/dio_client.dart';
import 'package:stadium_eye/features/profile/data/datasources/profile_remote_ds.dart';
import 'package:stadium_eye/features/profile/data/models/userprofile_model.dart';
import 'package:stadium_eye/core/networking/endpoints.dart';
class ProfileRemoteDsImpl implements ProfileRemoteDs {
 // final String baseUrl;
 // final String? token;

 // ProfileRemoteDsImpl();


  @override
  Future<void> createUserProfile(UserProfileModel userprofile) async {
   // final url = "$baseUrl/users"; // ??????????????????????????????????????????????? us؟
    final url =   UserEndpoints.myProfile;
    final dio = DioClient.create();

    final response = await dio.get(url);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(
        "Failed to create profile: ${response.statusCode} - ${response.data}",
      );
    }
  }

   @override
  Future<UserProfileModel> getMyUserProfile() async {
  //  final url = "$baseUrl/users/me";
     final url = Endpoints.baseUrl + UserEndpoints.myProfile;
     final dio = DioClient.create();

    final response = await dio.get(
      url
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Failed to fetch profile: ${response.statusCode} - ${response.data}",
      );
    }

     return UserProfileModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
