import 'dart:convert';
import 'package:dio/dio.dart';

Future<String> translateText(String text, String targetLanguage) async {
  try {
    final dio = Dio();
    final response = await dio.post(
      'http://10.0.2.2:3000/translate',
      options: Options(
        contentType: 'application/json',
      ),
      data: jsonEncode({
        'text': text,
        'target': targetLanguage,
      }),
    );
    print('result : ' + response.data['result']);
    if (response.statusCode == 200) {
      return response.data['result'];
    } else {
      return response.data[''];
      // throw Exception('Failed to load translation');
    }
  } catch (e) {
    print('Error en la solicitud de traducción: $e');
    return '';
  }
}
