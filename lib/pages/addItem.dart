import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:nitesh_host/shared/decoration.dart';

class AddItemUi extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItemUi> {
  File _image;
  List<String> _categoryList = List();
  List<Color> _colorList = List();
  List<String> _detailsList = List();
  String _category;
  String _details;
  String _color;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  Color ignore = Color(0xff443a49);

  final _formkey = GlobalKey<FormState>();
  final _detailskey = GlobalKey<FormState>();
  final _categorykey = GlobalKey<FormState>();


  double sizeboxheight = 15.0;
  double sizeboxwidth = 10.0;


  Color buttonColor = Color(0xff0c949b);
  Color containerColor = Colors.white;

  getImage(ImageSource source) async {
    var image = await ImagePicker().getImage(
      source: source,
    );
    File cropperFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9,
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.green,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
      maxWidth: 2180,
      maxHeight: 1440,
    );

    var result = await FlutterImageCompress.compressAndGetFile(
      image.path,
      cropperFile.path,
      quality: 100,
    );

    setState(() {
      _image = result;
    });
  }
  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
      currentColor = pickerColor;

    });


  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: buttonColor,
          title: Text('AddItem'),
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [

                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: SingleChildScrollView(
                              child: Card(
                                child: Container(
                                    height: 200,
                                    child: _image == null
                                        ? Text('Choose Image')
                                        : FittedBox(child: Image.file(_image))),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  RaisedButton(
                                    shape: StadiumBorder(),
                                    color: buttonColor,
                                    onPressed: () => getImage(ImageSource.camera),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                  RaisedButton(
                                    shape: StadiumBorder(),
                                    color: buttonColor,
                                    onPressed: () => getImage(ImageSource.gallery),
                                    child: Icon(
                                      Icons.photo_size_select_actual,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(

                                decoration: BoxDecoration(
                                    color: containerColor,
                                    border: Border(
                                      top: BorderSide(color: Colors.black,width: 0.1),
                                      bottom: BorderSide(color: Colors.black,width: 0.1),
                                      right: BorderSide(color: Colors.black,width: 0.1),
                                      left: BorderSide(color: Colors.black,width: 0.1),
                                    )
                                ),
                                height: 250,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Text('Category',style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(height: 5,),
                                      Form(
                                        key: _categorykey,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: TextFormField(
                                                decoration: inputdecoration.copyWith(labelText: 'Category'),
                                                validator: (val) =>
                                                val.isEmpty ? 'Enter The Category' : null,
                                                onChanged: (val) => _category = val,
                                              ),
                                            ),
                                            Expanded(
                                              child: IconButton(
                                                icon: Icon(Icons.add),
                                                onPressed: () {
                                                  if (_categorykey.currentState.validate()) {
                                                    setState(() {
                                                      _categoryList.add(_category);
                                                    });
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: _categoryList.length,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext, index) {
                                              List<String> _reversedcategorylist =
                                              _categoryList.reversed.toList();
                                              return ListTile(
                                                  title: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                            _reversedcategorylist[index].toString()
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: IconButton(
                                                          icon: Icon(Icons.cancel),
                                                          onPressed: (){

                                                            setState(() {

                                                              int deleteindex = _categoryList.length-1 -index;

                                                              _categoryList.removeAt(deleteindex);
                                                            });

                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: containerColor,
                                    border: Border(
                                      top: BorderSide(color: Colors.black,width: 0.1),
                                      bottom: BorderSide(color: Colors.black,width: 0.1),
                                      right: BorderSide(color: Colors.black,width: 0.1),
                                      left: BorderSide(color: Colors.black,width: 0.1),
                                    )
                                ),
                                height: 250,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Text('Colour',style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: GestureDetector(
                                                onTap: (){
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        titlePadding: const EdgeInsets.all(0.0),
                                                        contentPadding: const EdgeInsets.all(0.0),
                                                        content: SingleChildScrollView(
                                                          child:  ColorPicker(
                                                            pickerColor: currentColor,
                                                            onColorChanged: changeColor,
                                                            colorPickerWidth: 300.0,
                                                            pickerAreaHeightPercent: 0.7,
                                                            enableAlpha: true,
                                                            displayThumbColor: true,
                                                            showLabel: true,
                                                            paletteType: PaletteType.hsv,
                                                            pickerAreaBorderRadius: const BorderRadius.only(
                                                              topLeft: const Radius.circular(2.0),
                                                              topRight: const Radius.circular(2.0),
                                                            ),
                                                          ),
                                                        ),
                                                      );

                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  width: width*0.5,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: currentColor,
                                                      borderRadius: BorderRadius.circular(20.0)
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Choose Color',
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                          ),
                                          Expanded(
                                            child: IconButton(
                                              icon: Icon(Icons.add),
                                              onPressed: () {
                                                bool colorexist = _colorList.contains(currentColor);
                                                print(colorexist);
                                                if(colorexist == false){
                                                  _colorList.add(currentColor);
                                                }


                                              },
                                            ),

                                          ),

                                        ],
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: _colorList.length,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext, index) {
                                              List<Color> _reversedcolorlist =
                                              _colorList.reversed.toList();
                                              return ListTile(
                                                  title: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Container(

                                                            height: 30,

                                                            decoration: BoxDecoration(
                                                                color: _reversedcolorlist[index],
                                                                borderRadius: BorderRadius.circular(15.0)
                                                            ),
                                                          )
                                                      ),
                                                      Expanded(
                                                        child: IconButton(
                                                          icon: Icon(Icons.cancel),
                                                          onPressed: (){

                                                            setState(() {
                                                              print('index == $index');
                                                              int deleteindex = _colorList.length-1 -index;
                                                              // print(deleteindex.toString());
                                                              // print('size == ');
                                                              // print(_colorList.length);

                                                              _colorList.removeAt(deleteindex);
                                                            });

                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sizeboxheight,),
                      TextFormField(

                        maxLength: 50,
                        decoration: inputdecoration.copyWith(labelText: 'Product Title '),
                        validator: (val) =>
                        val.isEmpty ? 'Enter The Product Title' : null,
                        onChanged: (val) => _category = val,
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Expanded(
                            child:TextFormField(

                              keyboardType: TextInputType.phone,
                              decoration: inputdecoration.copyWith(labelText: ' MRP '),
                              validator: numbervalidtion,
                              onChanged: (val) => _category = val,
                            ),
                          ),
                          SizedBox(width: sizeboxwidth,),
                          Expanded(
                            child:TextFormField(

                              keyboardType: TextInputType.phone,
                              decoration: inputdecoration.copyWith(labelText: 'Selling Price '),
                              validator: numbervalidtion,
                              onChanged: (val) => _category = val,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sizeboxheight,),
                      Row(
                        children: [
                          Expanded(
                            child:TextFormField(

                              keyboardType: TextInputType.phone,
                              decoration: inputdecoration.copyWith(labelText: ' MaxBuyingQty '),
                              validator: numbervalidtion,
                              onChanged: (val) => _category = val,
                            ),
                          ),
                          SizedBox(width: sizeboxwidth,),
                          Expanded(
                            child:TextFormField(

                              keyboardType: TextInputType.phone,
                              decoration: inputdecoration.copyWith(labelText: 'Available Quantity '),
                              validator: numbervalidtion,
                              onChanged: (val) => _category = val,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sizeboxheight,),

                      Container(

                        decoration: BoxDecoration(
                            color: containerColor,
                            border: Border(
                              top: BorderSide(color: Colors.black,width: 0.1),
                              bottom: BorderSide(color: Colors.black,width: 0.1),
                              right: BorderSide(color: Colors.black,width: 0.1),
                              left: BorderSide(color: Colors.black,width: 0.1),
                            )
                        ),
                        height: 250,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Text('Category',style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Form(
                                key: _detailskey,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: TextFormField(
                                        decoration: inputdecoration.copyWith(labelText: 'Details',),
                                        validator: (val) =>
                                        val.isEmpty ? 'Enter The Details' : null,
                                        onChanged: (val) => _details = val,
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          if (_detailskey.currentState.validate()) {
                                            setState(() {
                                              _detailsList.add(_details);
                                            });
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: _detailsList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext, index) {
                                      List<String> _reverseddetailslist =
                                      _detailsList.reversed.toList();
                                      return ListTile(
                                          title: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                    _reverseddetailslist[index].toString()
                                                ),
                                              ),
                                              Expanded(
                                                child: IconButton(
                                                  icon: Icon(Icons.cancel),
                                                  onPressed: (){

                                                    setState(() {

                                                      int deleteindex = _detailsList.length-1 -index;

                                                      _detailsList.removeAt(deleteindex);
                                                    });

                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: sizeboxheight,),
                      RaisedButton(
                        shape: StadiumBorder(),
                        child: Text('Upload'),
                        color: buttonColor,
                        onPressed: (){
                          if(_formkey.currentState.validate())
                          {

                          }

                        },
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
  String numbervalidtion(String value){
    Pattern patter = r'^[0-9]$';
    RegExp regExp = new RegExp(patter);
    if(!regExp.hasMatch(value)){
      return 'Enter The Number Only';
    }
    else{
      return null;
    }
  }
}

