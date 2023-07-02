import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'http://127.0.0.1:5000/images/postimage'; // change this to match your API url
  
  static Future<String> sendImageAndGetResponse(String imagePath) async {
    final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    final decodedResponse = json.decode(responseString);
    return decodedResponse['response'];
  }
}
