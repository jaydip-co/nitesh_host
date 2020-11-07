
import 'package:flutter/material.dart';
import 'package:nitesh_host/DataBaseService.dart';
import 'package:nitesh_host/Models/SellerItem.dart';
import 'package:nitesh_host/constants.dart';

class ItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: StreamBuilder<List<SellerItem>>(
        stream: DataBaseService().SellerItems,
        builder: (context, snapshot) {
          final data = snapshot.data;
          return ListView.builder(
              itemCount: data.length ?? 7,
              itemBuilder: (con,i){
                print(data[i].ItemTitle);
                print(data[i].category);
            return GestureDetector(
                  onTap: ()async{
                    // controller.stop();
                    // await _tempProduct.setProduct(snapshot.data.documents[index].documentID);
                    // return _pageprovider.setpages('Product',_pageprovider.page);
                  },
                  child: Card(

                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black,width: 0.4),borderRadius: BorderRadius.circular(4.0)),
                    clipBehavior: Clip.antiAlias,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          child: Container(
                              width:  180,
                              height: 150,
                            // child: Image(
                              //   image: NetworkImage(snapshot.data.documents[index]['Images'][0]),
                              // )
                          ),
                        ),

                        Expanded(
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // snapshot.data.documents[index]['ItemTitle'].toString() + '',
                                data[i].ItemTitle,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0
                                ),
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Text(
                                    '₹',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  SizedBox(width: 4,),
                                  // EasyRichText(
                                  //   '₹',
                                  //   patternList: [
                                  //     EasyRichTextPattern(
                                  //       targetString: '₹',
                                  //       subScript: true,
                                  //       //Only TM after Product will be modified
                                  //       stringBeforeTarget: 'Product',
                                  //       //There is no space between Product and TM
                                  //       matchWordBoundaries: false,
                                  //       style: TextStyle(
                                  //
                                  //           decoration: TextDecoration.lineThrough,
                                  //           fontSize: 17.0
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(width: 4,),
                                  Text(
                                    'Save '+'₹',
                                    style: TextStyle(

                                      fontSize: 14.0,

                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 5,),
                              // Text(
                              //   'Free Delivery',
                              //   style: TextStyle(
                              //
                              //     fontSize: 15.0,
                              //
                              //   ),
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
          });
        }
      ),
    );
  }
}
