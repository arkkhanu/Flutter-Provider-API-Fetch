import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_fetch_provider/Services/Todo_Provider.dart';
import 'package:provider/provider.dart';

class Dashboard1_Screen extends StatefulWidget {
  @override
  _Dashboard1_ScreenState createState() => _Dashboard1_ScreenState();
}

class _Dashboard1_ScreenState extends State<Dashboard1_Screen> {
  Todo_Provider _todo_provider;

  @override
  void initState() {
    _todo_provider = Provider.of<Todo_Provider>(context, listen: false);
    _todo_provider.setTodoFromNetWork();
    _todo_provider.setListTodoFromNetWork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title:
            Text(ModalRoute.of(context).settings.name.substring(1) ?? "Null"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Fake Network Fetch"),
            SizedBox(
              height: 50,
            ),
            Card(
              child: Container(
                child: buildList(),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Todo_Provider todo = Todo_Provider();
                  todo.getTodoFromNetWork();
                },
                child: Text("Click Me")),
            Consumer<Todo_Provider>(
              builder: (context, _consumerTodo_Provider, child) {
                return _consumerTodo_Provider.getTodoModal == null
                    ? InkWell(
                        onTap: () {
                          _consumerTodo_Provider.setTodoFromNetWork();
                        },
                        child: Text("No Data"))
                    : Text(_consumerTodo_Provider.getTodoModal.title);
                /*  print("Consumer:"+_consumerTodo_Provider.getTodoModal.toString());
                return Text(
                    */ /*_consumerTodo_Provider.getTodoModal.title ??*/ /* "HelloNull");*/
              },
            ),
          ],
        ),
      ),
    ));
  }

  Widget buildList() {
     return Consumer<Todo_Provider>(
            builder: (context, _consumerTodo, child) {
           return   _todo_provider.getTodoModalList.length == 0 ? Center(child: InkWell(onTap: () {
                _todo_provider.setListTodoFromNetWork();
              }, child: Text("No Network"))) :
               ListView.builder(
                shrinkWrap: true,
                itemCount: _consumerTodo.getTodoModalList.length-180,
                itemBuilder: (context, index) => Text("Name :"+_consumerTodo.getTodoModalList[index].title),
              );
            },
          );
  }

  @override
  void dispose() {
    _todo_provider.disposeing();
    super.dispose();
  }
}
