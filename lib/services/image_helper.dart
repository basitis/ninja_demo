import 'package:path_provider/path_provider.dart';

class ImageHelper {
  static String path = '';

  Future<void> init() async {
    try {
      path = (await getApplicationDocumentsDirectory()).path;
    } catch (e) {
      path = '';
    }
  }
}
