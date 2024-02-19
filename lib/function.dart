import 'package:http/http.dart' as http;

fetchdata(String url) async{
  http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return response.body; // Return the response body as a String
  } else {
    throw Exception('Failed to fetch data: ${response.statusCode}');
  }
}