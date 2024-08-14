// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_provider/const/colors.dart';
import 'package:todo_app_with_provider/controller/todo_controller.dart';
import 'package:todo_app_with_provider/utils/validator.dart';

class AddUserScreen extends StatefulWidget {
  bool isEdit;
  Map<String, dynamic> userdata;

  AddUserScreen({required this.isEdit, required this.userdata, super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  final ValueNotifier<bool> _isVisiable = ValueNotifier<bool>(true);

  @override
  void initState() {
    if (widget.isEdit == true) {
      userNameC.text = widget.userdata['name'];
      passwordC.text = widget.userdata['password'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("State Call ${_isVisiable.value}");
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(widget.isEdit == true ? "Edit User" : 'Add User'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: userNameC,
                cursorColor: AppColors.primaryColor,
                cursorRadius: const Radius.circular(5),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.greyColor, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.primaryColor, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.redColor, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.redColor, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  labelText: 'Enter your name',
                  labelStyle: TextStyle(
                    color: AppColors.greyColor,
                  ),
                ),
                validator: (value) => FieldValidator.validateName(value!),
              ),
              const SizedBox(height: 13),
              ValueListenableBuilder(
                valueListenable: _isVisiable,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: passwordC,
                    cursorColor: AppColors.primaryColor,
                    cursorRadius: const Radius.circular(5),
                    obscureText: _isVisiable.value,
                    keyboardType: TextInputType.visiblePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.greyColor, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.primaryColor, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.redColor, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.redColor, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: AppColors.greyColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _isVisiable.value = !_isVisiable.value;
                        },
                        icon: Icon(value == true
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded),
                      ),
                    ),
                    validator: (value) =>
                        FieldValidator.validatePassword(value),
                  );
                },
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    if (userNameC.text.trim().isNotEmpty &&
                        passwordC.text.trim().isNotEmpty) {
                      try {
                        final todoController =
                            Provider.of<ToDoController>(context, listen: false);
                        todoController.startLoading();
                        if (widget.isEdit == true) {
                          todoController.updateData(
                            widget.userdata["id"],
                            userNameC.text,
                            passwordC.text,
                          );
                        } else {
                          todoController.saveData(
                            userNameC.text.trim(),
                            passwordC.text.trim(),
                          );
                        }
                        todoController.stopLoading();
                        Navigator.pop(context);
                      } catch (e) {
                        print(e);
                      }
                    }
                  }
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: Consumer<ToDoController>(
                    builder: (context, value, child) {
                      return value.isLoading == true
                          ? CircularProgressIndicator(
                              color: AppColors.whiteColor)
                          : Text(
                              widget.isEdit == true ? "Update" : "Save",
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
