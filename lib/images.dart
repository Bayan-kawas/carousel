import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ImageTest {
 final String path;
 ImageTest({this.path});

  void callEndPoint() async {
    var url =
        "http://api.syal.travninja.syal.com.sa/hotel_details?hotel_code=1128571";
    var response = await http.get(url);
    var obj = convert.jsonDecode(response.body);
    var hotelObj = obj['hotel']['images'];
    List apiImages = [];
    for (var i = 0; i < hotelObj.length; i++) {
      apiImages.add(hotelObj[i]['path']);
    }
  }
  factory ImageTest.fromJson(Map<String,dynamic> json){
    return new ImageTest(
      path: json['thumbnailUrl'],
    );
  }
}
