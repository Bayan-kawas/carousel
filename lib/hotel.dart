class Hotel{
  final String name ;
  final String code;
  final String description;
  final List<dynamic> images;
  Hotel({this.name,this.code,this.description,this.images});
  factory Hotel.fromJson(Map<String,dynamic>json){
    return Hotel(
      name:json['hotel']['name'],
      code:json['hotel']['code'],
      description:json['hotel']['description'],
      images:json['hotel']['images']
    );
  }
}