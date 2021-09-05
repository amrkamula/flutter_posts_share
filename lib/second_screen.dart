import 'package:flutter/material.dart';
import 'package:flutter_app_net/network_handler.dart';

class SecondScreen extends StatefulWidget {
  final String type;
  int? id;
  SecondScreen({required this.type,this.id});
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  var _key = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('CREATE POST'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      validator: (value){
                        if(value == null ||value.isEmpty){
                          return 'Please, enter a title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Post Title',
                      ),
                    ),
                    SizedBox(height: 12.0,),
                    TextFormField(
                      controller: _bodyController,
                      validator: (value){
                        if(value == null ||value.isEmpty){
                          return 'Please, enter a body';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Post Body',
                      ),
                    ),
                    SizedBox(height: 12.0,),
                    Center(child: Card(
                      elevation: 12.0,
                      child: Container(
                        color: Colors.indigo,
                        child: (widget.type=='a')?TextButton(
                          child: Text('ADD',style: TextStyle(fontSize: 20.0,color: Colors.white),),
                          onPressed: (){
                            if(_key.currentState!.validate()){
                              Post post = Post(
                                userId: 1,
                                title: _titleController.text,
                                body: _bodyController.text,
                              );
                              addPost(post);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('user added successfully',style: TextStyle(color: Colors.white,fontSize: 20.0),),backgroundColor: Colors.indigo,duration: Duration(seconds: 1),));
                              _titleController.clear();
                              _bodyController.clear();
                            }
                          },
                        ):TextButton(
                          child: Text('UPDATE',style: TextStyle(fontSize: 20.0,color: Colors.white),),
                          onPressed: (){
                            if(_key.currentState!.validate()){
                              Post post = Post(
                                userId: 1,
                                id: widget.id!,
                                title: _titleController.text,
                                body: _bodyController.text,
                              );
                              var res =  updatePost(widget.id!.toString(),post);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('user updated successfully',style: TextStyle(color: Colors.white,fontSize: 20.0),),backgroundColor: Colors.indigo,duration: Duration(seconds: 1),));
                              _titleController.clear();
                              _bodyController.clear();
                            }
                          },
                        ),
                      ),
                    ),),
                  ],
            ))
          ],
        ),
      ),
    );
  }



}
