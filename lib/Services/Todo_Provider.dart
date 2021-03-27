import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_api_fetch_provider/Services/API_Fetch.dart';
import 'package:flutter_api_fetch_provider/Services/TodoModal.dart';

class Todo_Provider with ChangeNotifier {
  /*TodoModal _todoModal;

  TodoModal get getTodoModal => _todoModal;

  Future<TodoModal> getTodoFromNetwork() async {
    _todoModal = null;
    String response;
    response = await API_Fetch.fetchSingleTodo();
    print("get");
    if (response != null) {
      if (response != "NetworkError" && response != "SocketError" && response != "null") {
        */ /*Iterable l = jsonDecode(response);
        var asd = List<TodoModal>.from(l.map((e) => TodoModal.fromJson(e)));*/ /*
       TodoModal _tempTodo = TodoModal.fromJson(jsonDecode(response));
       _tempTodo != null ? _todoModal = _tempTodo : _todoModal = null;
       print("response :"+_todoModal.title);
       return _todoModal;
      }
      else {
        if (response == "NetworkError") {
          print("NetWork Error");
          return null;
        }
        else {
          print("Socket Error");
          return null;
        }
      }
    }
    return _todoModal;
  }

  Future<void> setTodoFromNetwork() async {
    await getTodoFromNetwork();
    print("Set");
    notifyListeners();
  }*/

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
        // print("response:"+jsonDecode(response).toString());
        // Iterable l = jsonDecode(response);
        // _ = List<TodoModal>.from(l.map((e) => TodoModal.fromJson(e)));
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
    List<TodoModal> _ = await getTodoListFromNetWork();
    if (_ != null) {
      _todoModalList = _;
      print("if-Set1" + _.toString());
      notifyListeners();
    } else {
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

  void disposeing() {
    _todoModal = null;
    _todoModalList = [];
  }
}
