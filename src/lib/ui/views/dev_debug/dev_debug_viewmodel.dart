import 'package:m360_app_corpsec/common/constants.dart';
import 'package:m360_app_corpsec/helpers/push.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/models/model.account.dart';
import 'package:stacked/stacked.dart';
import 'package:m360_app_corpsec/helpers/store.dart';

class DevDebugViewModel extends BaseViewModel {
  String? fcmToken = "test test test";
  String? accessToken = "test test test";
  String? refreshToken = "test test test";
  String? exp = "test test test";

  Future<void> init() async {
    final e = await StoreHelper.read(StoreKey.EXP);
    final ac = await StoreHelper.read(StoreKey.ACCESS_TOKEN);
    final rt = await StoreHelper.read(StoreKey.REFRESH_TOKEN);
    Utils.log(e);
    fcmToken = PushHelper.fcmToken;
    accessToken = ac;
    refreshToken = rt;
    exp = DateTime.fromMillisecondsSinceEpoch(int.tryParse(e!)! * 1000).toLocal().toString();
    //fcmToken = await StoreHelper.read(StoreKey.PREF_FCM_TOKEN);
    Utils.log("dev debug init $fcmToken");
    notifyListeners();
  }

  void deleteRefreshToken() async {
    StoreHelper.delete(StoreKey.REFRESH_TOKEN);
    refreshToken = null;
    notifyListeners();
    final flag = await StoreHelper.read(StoreKey.USE_BIOMETRIC_FLAG);
    // await StoreHelper.clearStorage();
    if (flag != null && flag == 'no') {
      StoreHelper.delete(StoreKey.USE_BIOMETRIC_FLAG);
    }
  }
}
