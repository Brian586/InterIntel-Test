import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAssistant {

  static Future<dynamic> getRequest(String link) async {

    var url = Uri.parse(link);

    http.Response response = await http.get(url);

    try{
      if(response.statusCode == 200) {
        String jsonData = response.body;
        var decodeData = jsonDecode(jsonData);

        return decodeData;
      }
      else
      {
        return "Failed";
      }
    }
    catch(exp) {
      return "Failed";
    }
  }
}