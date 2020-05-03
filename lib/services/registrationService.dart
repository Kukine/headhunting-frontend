import 'package:headhunting_flutter/models/user.dart';
import 'package:http/http.dart';

class RegistrationService{

  final String registraonUrl = "https://kukine-headhunting.herokuapp.com/api/user/register";

  Future<String> registerUser(User user) async{
    Map<String,String> headers = {"Content-type": "application/json"};
    String jsonBody = user.toJson();
    Response response = await post(registraonUrl, headers: headers, body: jsonBody);
    print('Status code for user registration: ' + response.statusCode.toString());
    print('Response Body : ' + response.body);                           
    if(response.statusCode==200){
      return 'Registration succesfull';
    }else if(response.body == "EMAIL_EXISTS"){
      return 'Registration failed: User with e-mail adress exists';
    } else{
      return 'Registration failed: Unknown reason';
    }
  }

}