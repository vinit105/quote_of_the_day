import 'package:quote_of_the_day/model/model.dart';
import 'package:http/http.dart' as http;
class  Remote{
  Future<Welcome?> getPost() async{

    final response = await http.get(Uri.parse('https://api.quotable.io/random'));
    if(response.statusCode == 200){
      var json = response.body;
      return welcomeFromJson(json);
    }
    return null;

  }
}