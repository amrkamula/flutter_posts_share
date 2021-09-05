import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_net/network_handler.dart';
import 'package:flutter_app_net/second_screen.dart';

void main(){
  runApp(PostsApp());
}

class PostsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Future<List>? _data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data = getPosts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SecondScreen(type:'a')));
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('POSTS'),
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(context){
    return FutureBuilder(
      future: _data,
      builder: (context,AsyncSnapshot<List> snapshot){
        List? postsList = snapshot.data;
        if(snapshot.hasData){
          return ListView.separated(
              itemBuilder: (context,index){
                Post post = Post.fromJson(postsList![index]);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text('${post.title}'),
                          subtitle: Text('${post.body}'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigo,
                            child: Text('${post.userId}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            child: IconButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SecondScreen(type: 'u',id: post.id,)));
                            }, icon: Icon(Icons.edit,color: Colors.indigo,)),
                          ),
                          Card(
                            child: IconButton(onPressed: (){
                              deletePost(post.id.toString());
                            }, icon: Icon(Icons.delete,color: Colors.red,)),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context,index)=> Container(height: 1.0,color: Colors.black,width: double.infinity,),
              itemCount: postsList!.length);
        }
        else if(snapshot.hasError){
          return Center(
            child: Column(
              children: [
                Icon(Icons.error,color: Colors.indigo,size: 100.0,),
                SizedBox(height: 20.0,),
                Text('Something went wrong!',style: TextStyle(color: Colors.black,fontSize: 30.0,fontWeight: FontWeight.bold),)
              ],
            ),
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(
              color: Colors.indigo,
              strokeWidth: 3.0,
            ),
          );
        }
      },
    );
  }
}
