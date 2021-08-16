import 'package:test/test.dart';
import 'package:wasteagram/models/food_waste_post.dart';

void main() {
  test('Test1: Post created from json should have appropriate property values', () {
    final date = '2020-01-01';
    const url = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    final food_waste_post = FoodWastePost.fromJSON({
      'date' : date,
      'imageURL' : url,
      'quantity' : quantity,
      'latitude' : latitude,
      'longitude' : longitude
    });

    expect(food_waste_post.date, 'Wednesday, January 1 2020');
    expect(food_waste_post.imageURL, url);
    expect(food_waste_post.quantity, quantity);
    expect(food_waste_post.latitude, latitude);
    expect(food_waste_post.longitude, longitude);
  });

  test('Test2: Post created from json should have appropriate property values', () {
    final date = '2021-08-10';
    const url = 'https://firebasestorage.googleapis.com/v0/b/wasteagram-c5995.appspot.com/o/1628615720078?alt=media&token=8d561418-50a0-4474-99f8-08204683e38c';
    const quantity = 1;
    const latitude = 398.2423;
    const longitude = -23.234234;

    final food_waste_post = FoodWastePost.fromJSON({
      'date' : date,
      'imageURL' : url,
      'quantity' : quantity,
      'latitude' : latitude,
      'longitude' : longitude
    });

    expect(food_waste_post.date, 'Tuesday, August 10 2021');
    expect(food_waste_post.imageURL, url);
    expect(food_waste_post.quantity, quantity);
    expect(food_waste_post.latitude, latitude);
    expect(food_waste_post.longitude, longitude);
  });

    test('Test3: Post created with named parameters should have appropriate property values', () {
    final date = 'Tuesday, August 10 2021';
    const url = 'https://firebasestorage.googleapis.com/v0/b/wasteagram-c5995.appspot.com/o/1628615720078?alt=media&token=8d561418-50a0-4474-99f8-08204683e38c';
    const quantity = 1;
    const latitude = 39.741385;
    const longitude = -105.3294983;

    final food_waste_post = FoodWastePost(
      date: date,
      imageURL: url,
      quantity: quantity,
      latitude: latitude,
      longitude: longitude
    );

    expect(food_waste_post.date, date);
    expect(food_waste_post.imageURL, url);
    expect(food_waste_post.quantity, quantity);
    expect(food_waste_post.latitude, latitude);
    expect(food_waste_post.longitude, longitude);
  });

  test('Test4: Post created with named parameters should have appropriate property values', () {
    final date = 'January 1, 2020';
    const url = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    final food_waste_post = FoodWastePost(
      date : date,
      imageURL : url,
      quantity : quantity,
      latitude : latitude,
      longitude : longitude
    );

    expect(food_waste_post.date, date);
    expect(food_waste_post.imageURL, url);
    expect(food_waste_post.quantity, quantity);
    expect(food_waste_post.latitude, latitude);
    expect(food_waste_post.longitude, longitude);
  });

}
