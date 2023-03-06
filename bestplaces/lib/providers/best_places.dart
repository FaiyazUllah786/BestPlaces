import 'dart:io';

import 'package:bestplaces/models/place.dart';
import 'package:flutter/material.dart';
import '../helper/db_helper.dart';

class BestPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: null,
      image: pickedImage,
    );
    _items.add(newPlace); //it will destroy on app  rebuild
    notifyListeners();

    DBHelper.insert(table: 'user_places', data: {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndsSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (elem) => Place(
            id: elem['id'],
            title: elem['title'],
            location: null,
            image: File(
              elem['image'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
