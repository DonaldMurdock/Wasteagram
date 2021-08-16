import '../functions/readable_date.dart';

class FoodWastePost {
  final String date;
  final double latitude;
  final double longitude;
  final int quantity;
  final String imageURL; 

  FoodWastePost({required this.date, 
    required this.latitude, 
    required this.longitude, 
    required this.quantity, 
    required this.imageURL
  });

  factory FoodWastePost.fromJSON(json) {
    return FoodWastePost(
      date: readableDate(DateTime.parse(json['date'])),
      latitude: json['latitude'],
      longitude: json['longitude'],
      quantity: json['quantity'],
      imageURL: json['imageURL']
    );
  }
}