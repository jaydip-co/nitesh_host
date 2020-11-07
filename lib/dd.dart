import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class MyHomePage1 extends StatefulWidget {
  @override
  _MyHomePageState1 createState() => _MyHomePageState1();
}

class _MyHomePageState1 extends State<MyHomePage1> {
  int selectedimage = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ui Demo'),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('SellerProduct')
                .doc('Torch')
                .snapshots(),
            builder: (context, imagesnapshot) {
              if (imagesnapshot.hasData) {
                return StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Order')
                        .doc('+919512676561-12')
                        .snapshots(),
                    builder: (context, orderSnapshot) {
                      if (orderSnapshot.hasData) {
                        Timestamp ordertimestamp =
                        orderSnapshot.data['OrderDate'];
                        DateTime orderdate = ordertimestamp.toDate();
                        Timestamp deliverytimestamp;
                        DateTime deliverydate;
                        if (orderSnapshot.data['DeliveryDate'] != 'null') {
                          deliverytimestamp =
                          orderSnapshot.data['DeliveryDate'];
                          deliverydate = deliverytimestamp.toDate();
                        }
                        return Column(
                          children: [
                            Container(
                                width: width,
                                height: height / 3,
                                //decoration: BoxDecoration(color: Colors.grey[100]),
                                child: Row(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (selectedimage > 0) {
                                                selectedimage =
                                                    selectedimage - 1;
                                              }
                                            });
                                          },
                                          icon: selectedimage > 0
                                              ? Icon(Icons.arrow_back)
                                              : Icon(
                                            Icons.repeat,
                                            color: Colors.transparent,
                                          ),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(),
                                        child: Image(
                                          image: NetworkImage(imagesnapshot
                                              .data['Images'][selectedimage]),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (selectedimage <
                                                imagesnapshot
                                                    .data['Images'].length -
                                                    1) {
                                              setState(() {
                                                selectedimage =
                                                    selectedimage + 1;
                                              });
                                            }
                                          },
                                          icon: selectedimage <
                                              imagesnapshot.data['Images']
                                                  .length -
                                                  1
                                              ? Icon(Icons.arrow_forward)
                                              : Icon(
                                            Icons.repeat,
                                            color: Colors.transparent,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: new BorderSide(
                                      color: Colors.black, width: 0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Center(
                                        child: Text(
                                          'OrderDetails',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                          color: Colors.black, thickness: 0.1),
                                      Text(
                                        'OrderId',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        orderSnapshot.data['OrderId'],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5.0),
                                          side: new BorderSide(
                                              color: Colors.black, width: 0.2),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Category           :  ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                  Expanded(
                                                      child: Text(orderSnapshot
                                                          .data['Category']))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Colors               :  ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                  Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                        color: Color(int.parse(
                                                            orderSnapshot
                                                                .data['Color']))),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Amount             :  ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                  Expanded(
                                                      child: Text(orderSnapshot
                                                          .data['GivenAmount']
                                                          .toString() +
                                                          '(' +
                                                          'Qty : ' +
                                                          orderSnapshot
                                                              .data['Quantity']
                                                              .toString() +
                                                          ')'))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'PaymentId        :  ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                  Expanded(
                                                      child: Text(orderSnapshot
                                                          .data['PaymentId']
                                                          .toString()))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Amount             :  ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                  Expanded(
                                                      child: Text(orderSnapshot
                                                          .data['GivenAmount']
                                                          .toString() +
                                                          '(' +
                                                          'Qty : ' +
                                                          orderSnapshot
                                                              .data['Quantity']
                                                              .toString() +
                                                          ')'))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'OrderDate         :  ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                  Expanded(
                                                      child: Text(orderdate
                                                          .toString()
                                                          .substring(0, 19)))
                                                ],
                                              ),
                                              SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'DeliveryDate     :  ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                  Expanded(
                                                    child: orderSnapshot.data[
                                                    'DeliveryDate'] !=
                                                        'null'
                                                        ? Text(
                                                        deliverydate.toString())
                                                        : Text(
                                                      'Not Delivered At',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5.0),
                                          side: new BorderSide(
                                              color: Colors.black, width: 0.2),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'BillingName               :  ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                  Expanded(
                                                      child: Text(orderSnapshot
                                                          .data['First']
                                                          .toString() + ' ' +
                                                          orderSnapshot
                                                              .data['Middle']
                                                              .toString() +
                                                          ' ' + orderSnapshot
                                                          .data['Last']
                                                          .toString()))
                                                ],
                                              ),
                                              SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'DeliveryAddress        :  ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                  Expanded(
                                                      child: Text(orderSnapshot
                                                          .data['Address']
                                                          .toString() + ',' +
                                                          orderSnapshot
                                                              .data['City']
                                                              .toString() +
                                                          ',' + 'Gujarat' +
                                                          ',' + orderSnapshot
                                                          .data['Pincode']
                                                          .toString()))
                                                ],
                                              ),
                                              SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'AlterNativeNumber   :  ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                  Expanded(
                                                      child: Text(orderSnapshot
                                                          .data['AlternativeNumber']
                                                          .toString()))
                                                ],
                                              ),
                                              SizedBox(height: 5,),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        );
                      } else {
                        return CircularProgressIndicator(
                            semanticsLabel: 'Loading',
                            valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.red),
                            backgroundColor: Colors.red);
                      }
                    });
              } else {
                return CircularProgressIndicator(
                    semanticsLabel: 'Loading',
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    backgroundColor: Colors.red);
              }
            }),
      ),
    );
  }
}