import 'package:stadium_eye/profile_feature/data/datasources/profile_remote_datasource.dart';
import 'package:stadium_eye/profile_feature/data/model/user_profile_model.dart';
import'package:dio/dio.dart';

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource{
  final String baseUrl;
  ProfileRemoteDatasourceImpl(this.baseUrl);
  @override
  Future<UserProfileModel>fetchUserProfile()async{
    final dio =Dio();
    final userprofileRes=await dio.get('$baseUrl/abi/userprofile');
    if(userprofileRes.statusCode!=200){
      throw Exception("Failed to load");
    }
    final userprofilejson = userprofileRes.data;//already map
    return UserProfileModel.fromJson(
      userprofilejson

    );
  }
}