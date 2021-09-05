import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


final apiLink = 'https://jsonplaceholder.typicode.com/posts';



Future<List> getPosts() async {
  http.Response response = await http.get(Uri.parse(apiLink));
  var _postsList = convert.jsonDecode(response.body);
  return _postsList;
}

Future addPost(Post post) async {
  http.Response response = await http.post(Uri.parse(apiLink),headers:<String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  }, body: convert.jsonEncode(post.toJson()));
  print(convert.jsonDecode(response.body));
  return convert.jsonDecode(response.body);
}

Future deletePost(String id) async {
  http.Response response = await http.delete(Uri.parse('$apiLink/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(convert.jsonDecode(response.body));
  return convert.jsonDecode(response.body);
}

Future updatePost(String id,Post post) async {
  http.Response response = await http.put(Uri.parse("$apiLink/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(post.toJson()));
  print(convert.jsonDecode(response.body));
  return convert.jsonDecode(response.body);
}

class Post {
  final int userId;
  int? id;
  final String title, body;

  Post({required this.userId, this.id,required this.title,required this.body});

  factory Post.fromJson(Map<String,dynamic> json){
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body
    };
  }

}