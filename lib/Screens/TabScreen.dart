import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_api_fetch_provider/Screens/SearchWidget.dart';
import 'package:flutter_api_fetch_provider/Services/TodoModal.dart';
import 'package:flutter_api_fetch_provider/Services/Todo_Provider.dart';
import 'package:provider/provider.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  // ValueChanged<String> searchTodo;
  List<TodoModal> _searchResult = [];
  List<TodoModal> _searchResult2 = [];
  TextEditingController controller = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();

  // String _quryTodo = "";
  Todo_Provider _todo_provider;

  /*void searchTodo(String _qury) {
    if (_todo_provider.getTodoModalList.length != 0) {
      final newTodosList = _todo_provider.getTodoModalList.where((_todoElement) {
        final title_1 = _todoElement.title.toLowerCase();
        final title_2_search = _qury.toLowerCase();
        return title_1.contains(title_2_search);
      }).toList();
      this._todo_provider.setSearchTodoList(newTodosList);
      */ /*setState(() {
       this._quryTodo = _qury;
       this._todo_provider.getTodoModalList = newTodosList;
     });*/ /*
    }
  }*/

  @override
  void initState() {
    _todo_provider = Provider.of<Todo_Provider>(context, listen: false);
    _todo_provider.setListTodoFromNetWork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tab View"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                buildSearchBox(),
                Expanded(
                    child:  Consumer<Todo_Provider>(
                            builder: (context, _consumer_Todo, child) {
                              if (_consumer_Todo.getIsLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (_consumer_Todo.getTodoModalList.length > 0) {
                                return  _searchResult.length != 0 || controller.text.isNotEmpty?
                                _buildSearchList()  : buildListViewBuilder(_consumer_Todo.getTodoModalList)
                                  /*ListView.builder(
                                  itemCount: _consumer_Todo.getTodoModalList.length,
                                  itemBuilder: (context, index) => Card(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(flex: 1, fit: FlexFit.tight, child: Text("User ID: ")),
                                              Flexible(flex: 1, fit: FlexFit.tight, child: Text(_consumer_Todo.getTodoModalList[index].userId)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(flex: 1, fit: FlexFit.tight, child: Text("ID: ")),
                                              Flexible(flex: 1, fit: FlexFit.tight, child: Text(_consumer_Todo.getTodoModalList[index].id)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(flex: 1, fit: FlexFit.tight, child: Text("Title: ")),
                                              Flexible(flex: 1, fit: FlexFit.tight, child: Text(_consumer_Todo.getTodoModalList[index].title)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(flex: 1, fit: FlexFit.tight, child: Text("Completed: ")),
                                              Flexible(
                                                flex: 1,
                                                fit: FlexFit.tight,
                                                child: Text(
                                                  _consumer_Todo.getTodoModalList[index].completed,
                                                  style: TextStyle(
                                                      color: _consumer_Todo.getTodoModalList[index].completed == "true" ? Colors.green : Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )*/;
                              } else {
                                return Center(
                                    child: InkWell(
                                        onTap: () {
                                          _todo_provider.setListTodoFromNetWork();
                                          _todo_provider.setIsLoading(true);
                                        },
                                        child: Text("No Data Found")));
                              }
                            },
                          )
                       ),
              ],
            ),
            Column(
              children: [
                buildSearchBox2(),
                Expanded(
                    child:  Consumer<Todo_Provider>(
                            builder: (context, _consumer_Todo, child) {
                              if (_consumer_Todo.getIsLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (_consumer_Todo.getTodoModalList.length > 0) {
                                return _searchResult2.length != 0 || controller2.text.isNotEmpty?
                                _buildSearchList2()  : buildListViewBuilder(_consumer_Todo.getTodoModalList);

                              } else {
                                return Center(
                                    child: InkWell(
                                        onTap: () {
                                          _todo_provider.setListTodoFromNetWork();
                                          _todo_provider.setIsLoading(true);
                                        },
                                        child: Text("No Data Found")));
                              }
                            },
                          )
                        ),
              ],
            ),
          ],
        ),
        // resizeToAvoidBottomInset: true,
      ),
    );
  }

  Widget _buildSearchList() {
    return buildListViewBuilder(_searchResult);
  }
  Widget _buildSearchList2() {
    return buildListViewBuilder(_searchResult2);
  }

  Widget buildListViewBuilder(List<TodoModal> _listModel) {
    return ListView.builder(
      itemCount: _listModel.length,
      itemBuilder: (context, index) => Card(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(flex: 1, fit: FlexFit.tight, child: Text("User ID: ")),
                  Flexible(flex: 1, fit: FlexFit.tight, child: Text(_listModel[index].userId)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(flex: 1, fit: FlexFit.tight, child: Text("ID: ")),
                  Flexible(flex: 1, fit: FlexFit.tight, child: Text(_listModel[index].id)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(flex: 1, fit: FlexFit.tight, child: Text("Title: ")),
                  Flexible(flex: 1, fit: FlexFit.tight, child: Text(_listModel[index].title)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(flex: 1, fit: FlexFit.tight, child: Text("Completed: ")),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(
                      _listModel[index].completed,
                      style: TextStyle(color: _listModel[index].completed == "true" ? Colors.green : Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        child: new ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: controller,
            decoration: new InputDecoration(hintText: 'Search', border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
            onPressed: () {
              controller.clear();
              onSearchTextChanged('');
            },
          ),
        ),
      ),
    );
  }
  Widget buildSearchBox2() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        child: new ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: controller2,
            decoration: new InputDecoration(hintText: 'Search', border: InputBorder.none),
            onChanged: onSearchTextChanged2,
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
            onPressed: () {
              controller2.clear();
              onSearchTextChanged2('');
            },
          ),
        ),
      ),
    );
  }


 void onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    if (_todo_provider.getTodoModalList.isNotEmpty) {
      _todo_provider.getTodoModalList.forEach((userDetail) {
        if (userDetail.title.toLowerCase().contains(text.toLowerCase()) || userDetail.id.contains(text)) {
          _searchResult.add(userDetail);
        }
      });
      setState(() {});
    }
  }

 void onSearchTextChanged2(String text) async {
    _searchResult2.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    if (_todo_provider.getTodoModalList.isNotEmpty) {
      _todo_provider.getTodoModalList.forEach((userDetail) {
        if (userDetail.title.toLowerCase().contains(text.toLowerCase()) || userDetail.id.contains(text)) {
          _searchResult2.add(userDetail);
        }
      });
      setState(() {});
    }
  }
}
