import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'model.dart';

class PetsProvider extends ChangeNotifier {
  static const apiEndpoint =
      'https://jatinderji.github.io/users_pets_api/users_pets.json';

  bool isLoading = true;
  String error = '';
  Pets pets = Pets(data: []);
  Pets searchedPets = Pets(data: []);
  String searchText = '';

  getDataFromAPI() async {
    try {
      Response response = await http.get(Uri.parse(apiEndpoint));
      if (response.statusCode == 200) {
        pets = petsFromJson(response.body);
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    updateData();
    // notifyListeners();
  }

  updateData() {
    searchedPets.data.clear();
    if (searchText.isEmpty) {
      searchedPets.data.addAll(pets.data);
    } else {
      searchedPets.data.addAll(pets.data
          .where((element) =>
              element.userName.toLowerCase().startsWith(searchText))
          .toList());
    }
    notifyListeners();
  }

  search(String userName) {
    searchText = userName;
    updateData();
  }
}
