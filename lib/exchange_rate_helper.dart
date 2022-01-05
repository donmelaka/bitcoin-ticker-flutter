import 'package:bitcoin_ticker/constants.dart';
import 'package:sprintf/sprintf.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExchangeRateHelper {
  String specificRateUrl = '${kcoinApiBaseUrl}exchangerate/%s/%s?apikey=%s';

  Future<double> getSpecificExchangeRate(String source, String target) async {
    var url =
        Uri.parse(sprintf.call(specificRateUrl, [source, target, kApiKey]));

    print(url.toString());
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body)["rate"];

    } else {
      return 0.0;
    }
  }
}
