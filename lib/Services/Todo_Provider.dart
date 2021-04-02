import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_api_fetch_provider/Services/API_Fetch.dart';
import 'package:flutter_api_fetch_provider/Services/TodoModal.dart';

class Todo_Provider with ChangeNotifier {

  bool _isLoading = false;

  bool get getIsLoading => _isLoading;

  void setIsLoading(bool _val){
    _isLoading = _val;
    notifyListeners();
  }

  TodoModal _todoModal;

  TodoModal get getTodoModal => _todoModal;

  List<TodoModal> _todoModalList;

  List<TodoModal> get getTodoModalList => _todoModalList;

  Future<List<TodoModal>> getTodoListFromNetWork() async {
    List<TodoModal> _ = [];
    print("getTodoFromNetWork");
    var response = await API_Fetch.fetchListOfTodo();
    if (response != null) {
      if (response != "NetworkError" &&
          response != "SocketError" &&
          response != "null") {
        _ = List<TodoModal>.from(jsonDecode(response).map((e) => TodoModal.fromJson(e)));
        print("---Length:" + _.length.toString());
        return _ != null ? _ : null;
      }
    }
    return _;
  }

  Future<TodoModal> getTodoFromNetWork() async {
    TodoModal _;
    print("getTodoFromNetWork");
    var response = await API_Fetch.fetchSingleTodo();
    if (response != null) {
      if (response != "NetworkError" &&
          response != "SocketError" &&
          response != "null") {
        _ = TodoModal.fromJson(jsonDecode(response));
        print("---:" + _.title);
        return _ != null ? _ : null;
      }
    }
    return _;
  }

  setListTodoFromNetWork() async {
    print("set");
    _todoModalList = [];
    _isLoading = true;
    List<TodoModal> _ = await getTodoListFromNetWork();
    _isLoading = false;
    if (_ != null) {
      // _isLoading = false;
      _todoModalList = _;
      print("if-Set1" + _.toString());
      notifyListeners();
    } else {
      // _isLoading = false;
      _todoModalList = [];
      print("else-Set1" + _.toString());
      notifyListeners();
    }
  }

  setTodoFromNetWork() async {
    print("set");
    _todoModal = null;
    TodoModal _ = await getTodoFromNetWork();
    if (_ != null) {
      _todoModal = _;
      print("if-Set" + _.toString());
      notifyListeners();
    } else {
      _todoModal = null;
      print("else-Set" + _.toString());
      notifyListeners();
    }
  }




 /* setSearchTodoList(List<TodoModal> _list){
    _todoModalList = _list;
    notifyListeners();
  }*/

  void disposeing() {
    _todoModal = null;
    _todoModalList = [];
    _isLoading = false;
  }
}
