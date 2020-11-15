import 'package:flutter/material.dart';



InputDecoration inputdecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff0c949b)),
        borderRadius: BorderRadius.circular(10.0)
    ),
    focusedErrorBorder:OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff0c949b)),
        borderRadius: BorderRadius.circular(10.0)
    ),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10.0)
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(10.0)
    ),

    labelStyle: TextStyle(
        color: Colors.black
    )
);