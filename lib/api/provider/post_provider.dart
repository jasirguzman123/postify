import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:postify/models/post.dart';
import 'package:postify/services/preferencer.dart';

class PostProvider {

  static const String URL='https://kbapi.herokuapp.com/api/LgYRY7FU.json';
  
  
  Future<List<Post>> getPosts() async {
    try{
      final response = await http.get(URL);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Preferencer.setUsersData(response.body.toString());
      }
      return buildResponse(response.body);
    }catch (e){
      print(e);
      final data = await Preferencer.getUsersData();
      print(json.decode(data)['data']['users']);
      if (data != null) {
        print('dasdasdsa');
        return buildResponse(data);
      }else {
        print('ndasdlaksdjas');
        return null;
      }
    }
  }

  List buildResponse(data) {
    List<Post> tmp = List<Post>();
    json.decode(data)['data']['users'].forEach((user) => tmp.add(Post.fromJson(user)));
    return tmp;
  }
}