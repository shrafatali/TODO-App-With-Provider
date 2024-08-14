import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_provider/const/colors.dart';
import 'package:todo_app_with_provider/controller/todo_controller.dart';
import 'package:todo_app_with_provider/views/add_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("TODO"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Consumer<ToDoController>(
            builder: (context, value, child) {
              if (value.todoList.isNotEmpty) {
                return ListView.builder(
                  itemCount: value.todoList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tileColor: AppColors.greyColor.withOpacity(.01),
                        title: Text("${value.todoList[index]["name"]}"),
                        subtitle: Text("${value.todoList[index]["password"]}"),
                        trailing: PopupMenuButton<int>(
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  Icon(Icons.edit_square),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Edit")
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 2,
                              child: Row(
                                children: [
                                  Icon(Icons.delete),
                                  SizedBox(width: 10),
                                  Text("Delete")
                                ],
                              ),
                            ),
                          ],
                          offset: const Offset(0, 0),
                          color: Colors.white,
                          icon: Icon(
                            Icons.more_vert_rounded,
                            color: AppColors.blackColor,
                          ),
                          elevation: 2,
                          onSelected: (val) {
                            if (val == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddUserScreen(
                                      isEdit: true,
                                      userdata: value.todoList[index]),
                                ),
                              );
                            } else if (val == 2) {
                              final todoController =
                                  Provider.of<ToDoController>(context,
                                      listen: false);
                              todoController
                                  .deleteData(value.todoList[index]["id"]);
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(
                child: Text(
                  "No Data",
                  style: TextStyle(color: AppColors.blackColor),
                ),
              );
            },
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
        tooltip: "Add User",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddUserScreen(isEdit: false, userdata: const {}),
            ),
          );
        },
        child: const Icon(Icons.person_add_alt_1_rounded),
      ),
    );
  }
}
