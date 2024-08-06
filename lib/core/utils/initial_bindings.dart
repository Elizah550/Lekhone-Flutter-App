import 'package:Lekhone/core/app_export.dart';
import 'package:Lekhone/core/network/network_info.dart';
import 'package:Lekhone/core/utils/pref_utils.dart';
import 'package:Lekhone/data/api_client.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    Get.put(ApiClient());
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
  }
}
