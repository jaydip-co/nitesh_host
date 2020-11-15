

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nitesh_host/DataBaseService.dart';
import 'package:nitesh_host/Models/OrderInfo.dart';
import 'package:nitesh_host/constants.dart';
class OrderItemScreen extends StatelessWidget {
  final OrderInfo order;
  TextEditingController controller;
  String reason = "";


  OrderItemScreen({this.order}){
   DataBaseService().setSeen(order.number);
   controller =  TextEditingController();
   controller.addListener(() {
     print(reason);
   });
  }
  TextStyle styleForLable = TextStyle(
      fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,

          fontSize: 16,
  );
  TextStyle styleForValue = TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 16
  );
  getVal()async{
   String s = await DataBaseService().getImageUrl("Torch") ?? "jaydip";
    print(s);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    FirebaseFirestore.instance.collection("SellerProduct").doc("Torch").get().then((value) => {
      print(value.data()['Images'][0])
    });
    //
    // getVal();


    final witdh = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(order.ItemName),
        ),
        body: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  order.ItemName,
                  style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child:
                Container(
                  padding: EdgeInsets.only(left: 2,right: 2),
                  margin: EdgeInsets.only(left: 10,right: 10),
                  alignment: Alignment.center,
                  height:200,
                  width: width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/nitesh-4ed9f.appspot.com/o/a869ff6c-d006-47e8-aea3-154a9edff63f.jpg?alt=media&token=041e6dc7-b438-4f9c-98b5-10b2e018efaf",
                    ),
                    fit: BoxFit.fill
                  )),
                  // child: FutureBuilder<String>(
                  //   future: DataBaseService().getImageUrl("Torch"),
                  //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  //     if(snapshot.hasData){
                  //       return Image.network(snapshot.data,centerSlice: Rect.fromCenter(height: 300,width: width,),);
                  //     }
                  //     else{
                  //       return Text("jaydi");
                  //     }
                  //   },
                  //
                  // ),
                ),
              ),

              SizedBox(height: 20,),
              Divider(height: 10, color: Colors.red,),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.grey[200]
                ),



                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(child: Text("Order Details",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w700),)),
                    SizedBox(height: 5,),
                    Text("OrderId",style: TextStyle(fontStyle: FontStyle.normal,fontWeight: FontWeight.w900,fontSize: 20),),
                    Text("8866939915-1"),
                    Divider(height: 10,thickness: 2,),
                    signleRow("Item Name", order.ItemName, context,styleForValue),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(width: witdh/2 - 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Color",style: styleForLable,), Text(":",style: styleForLable,)
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,top: 5),
                        child: Container(color: Colors.red,
                        height: 10,
                        width: 10,),
                      ),

                    ],
                  ),
                    signleRow("Category", order.Category, context,styleForValue),
                    signleRow("Quantity", order.quantity.toString(), context,styleForValue),
                    signleRow("price", order.PaidAmmount.toString(), context,styleForValue),
                    signleRow("Order Date",order.OrderDate.toString() , context,styleForValue),
                    signleRow("Delivery Date","Not defined",context,TextStyle(color: Colors.red,fontSize: 16)), Divider(height:10,thickness: 2,),
                    signleRow("Billing Name", order.first+" "+order.last, context,styleForValue),
                    signleRow("Delivery Address",order.address+", "+order.city+", "+"${order.pincode}." , context,styleForValue),

                SizedBox(height: 10,)
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(0.0),
          margin: EdgeInsets.all( 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 50,
                width: witdh/2,
                child: RaisedButton(
                  color: Colors.red,
                  onPressed: (){
                    // showBottomSheet(context);
                    DataBaseService().setCancel(order.number);
                  },
                  child: Text("Cancel",),
                ),
              ),
              Container(
                height: 50,
                width: witdh / 2,
                child: RaisedButton(
                  color: Colors.green,
                  onPressed: (){
                    // Firestore.instance.collection("Order").doc("+919512676561-10")
                    //     .update({
                    //   "seen": true
                    // });
                    // showBottomSheet(context);
                    DataBaseService().ConfirmOrder(order.number);
                    Navigator.pop(context);
                  },
                  child: Text("Conform"),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
  void showBottomSheet(BuildContext context ){
    showModalBottomSheet(context: context,
        enableDrag: true,
        isScrollControlled: true,
        builder:(con){
      return SingleChildScrollView(
        child: Container(

          child: Column(
            children: <Widget>[
              Text('Enter reason for dined'),
              TextField(
                controller: controller,
                onChanged: (v){
                  reason = v;
                },

              ),
              Center(
                child: RaisedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("hide"),
                ),
              ),
            ],
          ),
        ),
      );
    }).then((value){
      Navigator.pop(context);
    });
  }
  Widget  signleRow(String Label,String Value ,BuildContext context,TextStyle ValueStyle){
    final witdh = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(width: witdh/2 - 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(Label,style: styleForLable,), Text(":",style: styleForLable,)
              ],
            )),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Container(

                  child: Text(Value,style: ValueStyle,maxLines: 2,)),
            )),

      ],
    );

  }
}
