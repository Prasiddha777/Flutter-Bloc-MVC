import 'package:bloc_mvc/data/network/network_api_services.dart';
import 'package:bloc_mvc/model/user/user_model.dart';
import 'package:bloc_mvc/utils/app_urls.dart';

class LoginRepository {
  final _api = NetworkApiService();

  Future<UserModel> loginApi(dynamic data) async {
    final resp = await _api.postApi(AppUrl.loginEndPint, data);
    return UserModel.fromJson(resp);
  }
}
