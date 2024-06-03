import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class Controller extends GetxController {
  final GetStorage storage = GetStorage();
  var mode = 'light'.obs;

  @override
  void onInit() {
    super.onInit();
    mode.value = storage.read('theme') ?? 'light';
  }

  void toggleMode() {
    mode.value = mode.value == 'dark' ? 'light' : 'dark';
    storage.write('theme', mode.value);
  }
}
