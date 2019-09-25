import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;



 Future<List> callEndPoint() async {
  var url =
      "http://api.syal.travninja.syal.com.sa/hotel_details?hotel_code=1128571";
  var response = await http.get(url);
  var obj = convert.jsonDecode(response.body);
  var hotelObj= obj['hotel']['images'];
  List hotelImages = [];
  for( var i=0; i < hotelObj.length ;i++){
    hotelImages.add(hotelObj[i]['path']);
  }
  return hotelImages;
}

