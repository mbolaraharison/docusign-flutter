///Dart import
import 'dart:io';

///Package imports
import 'package:path_provider/path_provider.dart';

// ignore: avoid_classes_with_only_static_members
///To save the pdf file in the device
class FileSaveHelper {
  ///To save the pdf file in the device
  static Future<String> saveFile(List<int> bytes, String fileName) async {
    try {
      final Directory directory = await getTemporaryDirectory();
      String path = directory.path;
      final File file = File('$path/$fileName');
      await file.writeAsBytes(bytes, flush: true);
      return '$path/$fileName';
    } catch (e) {
      throw Exception(e);
    }
  }
}
