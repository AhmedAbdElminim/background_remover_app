import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void defaultShowToAst({required String msg, required bool isError}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: isError ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
