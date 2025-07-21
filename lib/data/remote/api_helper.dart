import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nova_chat/data/remote/urls.dart';

class ApiHelper{
  Future<dynamic> sendMsgApi({required String userMsg}) async {
    try {
      final uri = Uri.parse(Urls.chatUrl);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": userMsg}
            ]
          }
        ]
      });

      final response = await http.post(uri, headers: headers, body: body); // Timeout handling

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        print("API Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } on SocketException {
      print("❌ No Internet connection.");
    } on FormatException {
      print("❌ Bad response format.");
    } on TimeoutException {
      print("❌ Request timed out.");
    } catch (e) {
      print("❌ Unexpected error: $e");
    }

    return null; // return null on failure
  }

}