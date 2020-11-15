

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nitesh_host/DataBaseService.dart';
import 'package:nitesh_host/Models/OrderInfo.dart';
import 'package:nitesh_host/OrderChangeNotifier.dart';
import 'package:nitesh_host/Providers/PageProvider.dart';
import 'package:nitesh_host/Screens/OrderItemScreen.dart';
import 'package:nitesh_host/constants.dart';
import 'package:flutter/services.dart';
import 'package:nitesh_host/pages/ItemsPage.dart';
import 'package:nitesh_host/pages/addItem.dart';
import 'package:provider/provider.dart';

import 'dd.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColor: Colors.red,
        primaryColorBrightness: Brightness.dark,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<PageProvider>.value(
        value: PageProvider(),
          child: ChangeNotifierProvider(
            create: (c) => OrderChangeNotifier(),
              child: MyHomePage(title: 'Flutter Demo Home Page'))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _currentSelection = 'new Order';
  final String serverToken= "AAAAyDHykpU:APA91bGybaVRBEVIPYjkOwkePEMUg0teZWy_ErEymI5eZXnqDfC1DvuRX1fMbDHmuVAqW-NFRplg1LKIoZSTu8y2z1USUeQfZ1Vt--rMmZomasb0mbf3rLjTzYM7UnBYHAOIM5mU1Zxr";
  int _currentIndex = 0;
  final FirebaseMessaging _messaging = FirebaseMessaging();
  final http.Client client = http.Client();
  @override
  void initState() {
    print("jaydip");
    _messaging.onTokenRefresh.listen((event) {
      print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"+event);
      DataBaseService.setToken(event);
    });
   _messaging.configure(
     onMessage:(mess){
       print("msg"+mess.toString());
     return null;
     }
   );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final currentPage = Provider.of<PageProvider>(context).currentPage;
    final currentOrder = Provider.of<OrderChangeNotifier>(context);
    String current = currentOrder.currentOrderStatus;
    Stream<List<OrderInfo>> _currentStream;
    switch(current){
      case 'new Order':
        _currentStream = DataBaseService().getOrder;
        break;
      case 'cancel':
        _currentStream = DataBaseService().calcelStream;
        break;
      case 'confirmed':
        _currentStream = DataBaseService().confirmStream;
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("app title"),
      ),
      // body: SingleOrder(),
      body: (currentPage == pages.Items) ? ItemsPage() :Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          DropdownButton(
            value: _currentSelection,
            items: ['new Order','cancel','confirmed'].map((e) {
              print(e);
              return DropdownMenuItem(
              child: Text(e),
                value: e.toString(),
              );
            }).toList(),
            onChanged: (value) {  setState(() {
              _currentSelection = value;
              currentOrder.setCurrentOrderStatus(value);
            });},

          ),
          StreamBuilder<List<OrderInfo>>(
            stream: _currentStream,
            builder: (context,snap){
              if(snap.hasData) {
                List<OrderInfo> orders = snap.data;
                return Expanded(
                  child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (_,i){
                    // return GestureDetector(
                    //   onTap: ()async{
                    //     // controller.stop();
                    //     // await _tempProduct.setProduct(snapshot.data.documents[index].documentID);
                    //     // return _pageprovider.setpages('Product',_pageprovider.page);
                    //   },
                    //   child: Card(
                    //
                    //     shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black,width: 0.4),borderRadius: BorderRadius.circular(4.0)),
                    //     clipBehavior: Clip.antiAlias,
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: <Widget>[
                    //         Card(
                    //           child: Container(
                    //               width:  180,
                    //               height: 150,
                    //
                    //
                    //               // child: Image(
                    //               //   image: NetworkImage(snapshot.data.documents[index]['Images'][0]),
                    //               // )
                    //           ),
                    //         ),
                    //
                    //         Expanded(
                    //           child:  Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 // snapshot.data.documents[index]['ItemTitle'].toString() + '',
                    //                 "jay",
                    //                 style: TextStyle(
                    //                     fontWeight: FontWeight.w400,
                    //                     fontSize: 16.0
                    //                 ),
                    //               ),
                    //               SizedBox(height: 5,),
                    //               Row(
                    //                 children: [
                    //                   Text(
                    //                     '₹',
                    //                     style: TextStyle(
                    //                       fontWeight: FontWeight.w400,
                    //                       fontSize: 18.0,
                    //                     ),
                    //                   ),
                    //                   SizedBox(width: 4,),
                    //                   // EasyRichText(
                    //                   //   '₹',
                    //                   //   patternList: [
                    //                   //     EasyRichTextPattern(
                    //                   //       targetString: '₹',
                    //                   //       subScript: true,
                    //                   //       //Only TM after Product will be modified
                    //                   //       stringBeforeTarget: 'Product',
                    //                   //       //There is no space between Product and TM
                    //                   //       matchWordBoundaries: false,
                    //                   //       style: TextStyle(
                    //                   //
                    //                   //           decoration: TextDecoration.lineThrough,
                    //                   //           fontSize: 17.0
                    //                   //       ),
                    //                   //     ),
                    //                   //   ],
                    //                   // ),
                    //                   SizedBox(width: 4,),
                    //                   Text(
                    //                     'Save '+'₹',
                    //                     style: TextStyle(
                    //
                    //                       fontSize: 14.0,
                    //
                    //                     ),
                    //                   ),
                    //
                    //                 ],
                    //               ),
                    //               SizedBox(height: 5,),
                    //               // Text(
                    //               //   'Free Delivery',
                    //               //   style: TextStyle(
                    //               //
                    //               //     fontSize: 15.0,
                    //               //
                    //               //   ),
                    //               // ),
                    //             ],
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // );
                    // if(curentPage == pages.Items){
                    //   return ItemsPage();
                    // }
                    return Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.black12),
                        color: orders[i].seen ? Colors.white :Colors.grey[200],),
                      margin: EdgeInsets.only(left: 5,right: 5),
                      padding:EdgeInsets.all(2),
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (con) => OrderItemScreen(order:orders[i] ,)));
                        },

                        contentPadding: EdgeInsets.all(0),
                        // isThreeLine: true,
                        // trailing: Image.network("https://firebasestorage.googleapis.com/v0/b/nitesh-4ed9f.appspot.com/o/sharingan.jpg?alt=media&token=1274aa3e-fd1e-49e7-b159-0ffeba9fd3f6"),
                        title: Text(orders[i].first+" has ordered torch",style: TextStyle(fontSize: 14,letterSpacing: .5),),
                        trailing: Container(
                          color: Colors.red,
                          height: 30,
                            width: 30,
                            margin: EdgeInsets.only(right: 10),
                            child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/nitesh-4ed9f.appspot.com/o/a869ff6c-d006-47e8-aea3-154a9edff63f.jpg?alt=media&token=041e6dc7-b438-4f9c-98b5-10b2e018efaf",
                              fit: BoxFit.fill,
                            )),
                      ),
                    );
                  }),
                );
              }
              return Container();
              },
          ),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          if(i == 1)
          Provider.of<PageProvider>(context,listen: false).setCurrentPage(pages.Orders);
          else
            Provider.of<PageProvider>(context,listen: false).setCurrentPage(pages.Items);
          setState(() {
            print(i);
            _currentIndex = i;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text("all"),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text("new"))
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //
      //   onPressed: ()async{
      //      //final String serverToken = "AAAAyDHykpU:APA91bGybaVRBEVIPYjkOwkePEMUg0teZWy_ErEymI5eZXnqDfC1DvuRX1fMbDHmuVAqW-NFRplg1LKIoZSTu8y2z1USUeQfZ1Vt--rMmZomasb0mbf3rLjTzYM7UnBYHAOIM5mU1Zxr";
      //     print("send");
      //     DateTime dateTime = DateTime.now();
      //     await client.post(
      //       'https://fcm.googleapis.com/fcm/send',
      //       headers: <String, String>{
      //         'Content-Type': 'application/json',
      //         'Authorization': 'key=$serverToken',
      //       },
      //       body: jsonEncode(
      //         <String, dynamic>{
      //           'notification': <String, dynamic>{
      //             'body': '${dateTime.toIso8601String()}',
      //             'title': 'lalit',
      //
      //           },
      //           'priority': 'high',
      //           'data': <String, dynamic>{
      //             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      //             'id': '2',
      //             'status': 'done'
      //           },
      //           'to':'dRdxOVSvQTGf4gbAlgmWFV:APA91bFkVQsGwtO8XRWW3N6tTkdp08CzDvuOb6137mck8JRfH7IMKC0U3uTUGA7MlBLRj8qwqnXzZPh_X5dj0E3Jn-QOD3pX1pa63sosw5BJbErUaZKV0cLyqBvzmcKz0yiKqHA9QlWD',
      //         },
      //       ),
      //     );
      //     // await client.post(
      //     //   'https://fcm.googleapis.com/fcm/send',
      //     //   headers: <String, String>{
      //     //     'Content-Type': 'application/json',
      //     //     'Authorization': 'key=$serverToken',
      //     //   },
      //     //   body: jsonEncode(
      //     //     <String, dynamic>{
      //     //       'notification': <String, dynamic>{
      //     //         'body': 'jane loda',
      //     //         'title': 'londe',
      //     //
      //     //       },
      //     //       'priority': 'high',
      //     //       'data': <String, dynamic>{
      //     //         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      //     //         'id': '1',
      //     //         'status': 'done'
      //     //       },
      //     //       'to':'dRdxOVSvQTGf4gbAlgmWFV:APA91bFkVQsGwtO8XRWW3N6tTkdp08CzDvuOb6137mck8JRfH7IMKC0U3uTUGA7MlBLRj8qwqnXzZPh_X5dj0E3Jn-QOD3pX1pa63sosw5BJbErUaZKV0cLyqBvzmcKz0yiKqHA9QlWD',
      //     //     },
      //     //   ),
      //     // );
      //
      //
      //   }
      //   ),
    );
  }
}
//mard9TFj9bgTzKJRnE_4b321T:APA91bGEcQfh7a_5u4q9lTKNokOLss4ZjyesY4A-2OoGTA6aQgMeUx0laa8Rpxo5cAV9N2eXVyTR9dv0th65WodGXROdFe30wbqdoWFwZDMMyIwLNWlgsLre9LB_f7FLRx6CYMnQ2q41

class SingleOrder extends StatelessWidget {
 final OrderInfo order;
  SingleOrder({this.order});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
        height: 100,
        width: width,
        color: Colors.grey[200],
        child: Card(
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey,
                    child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/nitesh-4ed9f.appspot.com/o/sharingan.jpg?alt=media&token=1274aa3e-fd1e-49e7-b159-0ffeba9fd3f6",
                            fit: BoxFit.fill,
                        ),

                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10,top: 10),
                        child: Text(order.first),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0,top: 10.0),
                        child: Text(order.last),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(order.address),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
