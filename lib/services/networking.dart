import 'package:http/http.dart' as http;
import 'dart:convert';

List<String> cryptoList = ['bitcoin', 'ethereum', 'litecoin'];

String apiUrl = 'https://api.coingecko.com/api/v3/coins';

class NetWorkHelper {
  static Future getData(currencyTxt) async {
    Map<String, String> result = {};
    for (String crypto in cryptoList) {
    
      String url =
          '$apiUrl/$crypto/market_chart?vs_currency=$currencyTxt&days=1';

      http.Response response = await http.get(Uri.parse(url));
    
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        result[crypto] = decodedData['prices'].last[1].toStringAsFixed(0);
      } else {
        throw 'This page is not found : ${response.statusCode}';
      }
    }

    return result;
  }
}