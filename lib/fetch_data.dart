import 'dart:convert';

import 'package:carousel/hotel.dart';
import 'package:flutter/material.dart';
import 'images.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class MainFetchData extends StatefulWidget {
  @override
  _MainFetchDataState createState() => _MainFetchDataState();
}

class _MainFetchDataState extends State<MainFetchData> {
   Future hotel;
  var isLoading = false;
  Future<Hotel> _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
    await http.get("http://api.syal.travninja.syal.com.sa/hotel_details?hotel_code=1128571");
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
     return Hotel.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey
      ),
      home:
      Scaffold(
          appBar: AppBar(
            title: Text("Fetch Data JSON"),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: new Text("Fetch Data"),
              onPressed: _fetchData,
            ),
          ),
          body: isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              :Center(
            child:
          FutureBuilder(
            future: _fetchData() ,
            builder:(context , snapshot){
             if(snapshot.hasData){
               var list =List();
               for(int i=0;i<snapshot.data.images.length;i++){
                 list.add(i);
               }
               return CarouselSlider(
                 height: 400,
                 aspectRatio: 16/9,
                 enableInfiniteScroll: true,
                 reverse: false,
                 autoPlay: true,
                 autoPlayCurve: Curves.easeIn,
                 pauseAutoPlayOnTouch: Duration(seconds: 10),
                 enlargeCenterPage: true,
                 items: list.map((i) {
                   return Builder(
                     builder: (BuildContext context) {
                       return Container(
                           width: MediaQuery.of(context).size.width,
                           margin: EdgeInsets.symmetric(horizontal: 5.0),
                           decoration: BoxDecoration(
                               color: Colors.white70
                           ),
                           child: Image.network('${snapshot.data.images[i]['path']}',
                               fit: BoxFit.cover
                           )
                       );
                     },
                   );
                 }).toList(),
               );
//               return ListView.builder(
//                   padding: const EdgeInsets.all(8),
//                   itemCount: snapshot.data.images.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return ListTile(
//                       contentPadding: EdgeInsets.all(10.0),
//                       title: new Text("${snapshot.data.name}"),
//                       trailing: new Image.network(
//                         snapshot.data.images[index]['path'],
//                         fit: BoxFit.cover,
//                         height: 40.0,
//                         width: 40.0,
//                       ),
//                     );
//                   }
//               );

             }
             else if(snapshot.hasData) {
               return Text("${snapshot.error}");
             }
             else{
               return CircularProgressIndicator();
             }
          },
          )

      )
      )
      );


  }
}
