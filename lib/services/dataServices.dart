
import 'package:headhunting_flutter/models/skill.dart';
import 'package:http/http.dart';


class DataServices{

  static final String baseUrl = "https://kukine-headhunting.herokuapp.com";

  Future<String> loadSkills() async {
    Map<String,String> headers = {"Content-type": "application/json"};
    Response response = await get(baseUrl + "/api/skills");
    return response.body;
  }
}