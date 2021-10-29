import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/models.dart';

class MockStudentService {
  Future<StudentHomeData> getStudentHomeData() async {
    final assignbooks = await _getAssignBooks();
    final favoritebooks = await _getFavoriteBooks();

    return StudentHomeData(assignbooks, favoritebooks);
  }

  Future<List<Book>> _getAssignBooks() async {
    // Simulate api request wait time
    await Future.delayed(const Duration(milliseconds: 1000));
    // Load json from file system
    final dataString =
        await _loadAsset('assets/sample_data/sample_assign_books.json');
    // Decode to json
    final Map<String, dynamic> json = jsonDecode(dataString);

    // Go through each recipe and convert json to ExploreRecipe object.
    if (json['assignBooks'] != null) {
      final assignBooks = <Book>[];
      json['assignBooks'].forEach((v) {
        assignBooks.add(Book.fromJson(v));
      });
      return assignBooks;
    } else {
      return [];
    }
  }

  Future<List<Book>> _getFavoriteBooks() async {
    // Simulate api request wait time
    await Future.delayed(const Duration(milliseconds: 1000));
    // Load json from file system
    final dataString =
        await _loadAsset('assets/sample_data/sample_favorite_books.json');
    // Decode to json
    final Map<String, dynamic> json = jsonDecode(dataString);

    // Go through each recipe and convert json to ExploreRecipe object.
    if (json['favoriteBooks'] != null) {
      final favoriteBooks = <Book>[];
      json['favoriteBooks'].forEach((v) {
        favoriteBooks.add(Book.fromJson(v));
      });
      return favoriteBooks;
    } else {
      return [];
    }
  }

  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }
}
