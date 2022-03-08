import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageScreen(),
    );
  }
}

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  String image="https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.elegantthemes.com%2Fblog%2Fwp-content%2Fuploads%2F2019%2F10%2Floading-screen-featured-image.jpg&imgrefurl=https%3A%2F%2Fwww.elegantthemes.com%2Fblog%2Fwordpress%2Fadd-a-loading-animation-to-your-wordpress-website&tbnid=1c54i_puGqBMiM&vet=12ahUKEwjYsZzfirT2AhUR4oUKHQ_tBJwQMygFegUIARDxAQ..i&docid=eJaxOeeUHFczbM&w=1080&h=608&q=image%20loading&ved=2ahUKEwjYsZzfirT2AhUR4oUKHQ_tBJwQMygFegUIARDxAQ";
   
     List trendimage=[];
  List photo_id=[];
   getImage()async{
    var apikey ='563492ad6f9170000100000140ccbf96712846169984f406bc0d064a';
    http.Response  response = await http.get(Uri.parse('https://api.pexels.com/v1/curated?page=2&per_page=80'),
    headers: {
      "Authorization":apikey,
    }
    );
    String data= response.body;
    var photoId;
    for(var i=1;i<80;i++){
      var photo = jsonDecode(data)['photos'][i]['src']['portrait'];
       photoId = jsonDecode(data)['photos'][i]['photographer_id'];
      photo_id.add(photoId);
      trendimage.add(photo);
    }
    setState(() {
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor:Colors.amber,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Boossto wall-papers",style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),),
                  ),
                ),
              ),
              Container(
                height: 700,
                child: ListView.builder(
                  itemCount: trendimage.length,
                  itemBuilder: (context,index){
                  return Container(
                    width:500,
                    height: 250,
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child: Image.network(trendimage[index],fit: BoxFit.cover,loadingBuilder:(context, child, loadingProgress) {
                                           if (loadingProgress == null) return child;
                                           return Center(
                                             child: CircularProgressIndicator(),
                                           );
                                         },),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
