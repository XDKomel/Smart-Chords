import 'dart:convert';
import 'dart:developer' as dev;

import 'package:dio/dio.dart';

import '../models/eyes_position.dart';

class EyeTracker {
  final dio = Dio(BaseOptions(responseType: ResponseType.plain));
  final uriPath =
      "https://eye-tracking-and-gaze-detection.p.rapidapi.com/gaze-detection";

  Future<EyesPosition?> getEyesPosition(String imageLink) async {
    final params = {"url": imageLink};
    try {
      final response = await dio.post(uriPath,
          data: params,
          options: Options(headers: {
            Headers.contentTypeHeader: "application/json",
            "X-RapidAPI-Key":
                "2b91737877msha8470a833e8207cp1281bajsn1e3746cd9a61",
            "X-RapidAPI-Host": "eye-tracking-and-gaze-detection.p.rapidapi.com",
          }));
      final data = jsonDecode(response.toString())[0];
      return EyesPosition(data["left_eye"]["y"], data["right_eye"]["y"]);
    } catch (e) {
      dev.log("Couldn't get eyes position:");
      dev.log(e.toString());
    }
    return null;
  }
}
