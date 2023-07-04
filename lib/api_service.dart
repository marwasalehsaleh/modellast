import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'http://0.0.0.0:5000/images/postimage'; // change this to match your API url
  static Future<String> sendImageAndGetResponse(String imagePath) async {
    late final response;
    late final decodedResponse;
    final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    print("request : $request");
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    print('adding image done');
    try{
      response = await request.send().then((value) async{ // TODO
        print('request sent \n');
    final responseString = await value.stream.bytesToString().then((value) {
      print('coming response : $value');
    decodedResponse = json.decode(value);
    });
      }); // TODO
    print('sending data to api');
    }catch(e){
      print('error while seending image : $e');
    }
    return decodedResponse['response'];
  }
}
