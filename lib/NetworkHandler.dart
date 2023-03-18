import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler
{
  var logger = Logger();

  String baseurl = "https://curly-termite-17.loca.lt/";

  Future post(String url,Map<String, String> body)async
  {
    url=formater(url);
    logger.d(url);
    var response = await http.post(
        Uri.parse(url),
        headers: {"Content-type": "application/json"},
        body: json.encode(body)
    );
    logger.d(response.body);
    return json.decode(response.body);
  }

  Future get(String url) async
  {
    url=formater(url);
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body.toString());
  }

  Future postIncome(String url, Map body)async
  {
    url=formater(url);
    var response = await http.post(
        Uri.parse(url),
        headers: {"Content-type": "application/json"},
        body: json.encode(body)
    );
    logger.d(url);
    logger.d(response.body);
    return json.decode(response.body);
  }

  Future postBudget(String url, Map<String, String> body)async
  {
    url=formater(url);
    var response = await http.post(
        Uri.parse(url),
        headers: {"Content-type": "application/json"},
        body: json.encode(body)
    );
    logger.d(response.body);
    return json.decode(response.body);
  }

  String formater(String url)
  {
    return baseurl + url;
  }
}
