import 'dart:convert';
import 'dart:developer' as dev;

import 'package:dio/dio.dart';

class IMGBB {
  final dio = Dio();
  final key = "3759ea760c10262c17a1ecda44b09798";
  final url = "https://api.imgbb.com/1/upload/";

  Future<String?> getImageLink(String imagePath, String expiration) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imagePath),
      'expiration': expiration,
      'key': key,
    });
    final response = await dio.post(
      'https://api.imgbb.com/1/upload',
      data: formData,
    );
    try {
      return jsonDecode(response.toString())["data"]["url"] as String;
    } catch (_) {
      dev.log("Couldn't upload the image to the imgbb");
    }
    return null;
  }
}
