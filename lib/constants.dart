

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class constants {
  AppBar appBar1 = AppBar(
    backgroundColor: Colors.red,
    title: Text("app Name",style: TextStyle(color: Colors.white),),
    centerTitle: true,
  );
  Widget  get appbar{
    return AppBar(
      backgroundColor: Colors.white,
      title: Text("app Name",style: TextStyle(color: Colors.white),),
      centerTitle: true,
    );
  }
}