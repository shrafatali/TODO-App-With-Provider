import 'package:flutter/material.dart';

class ToDoController with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<Map<String, dynamic>> _todoList = [];
  List<Map<String, dynamic>> get todoList => _todoList;

  startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  saveData(String userName, String password) {
    int listLength = _todoList.length + 1;
    _todoList.add({
      'id': listLength,
      'name': userName,
      'password': password,
    });
    notifyListeners();
  }

  deleteData(int id) {
    _todoList.removeWhere((element) => element['id'] == id);
    notifyListeners();
  }

  updateData(int id, String userName, String password) {
    for (var element in _todoList) {
      if (element['id'] == id) {
        element['name'] = userName;
        element['password'] = password;
      }
    }
    notifyListeners();
  }
}
