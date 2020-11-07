import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nitesh_host/Models/OrderInfo.dart';
import 'package:nitesh_host/Models/SellerItem.dart';

class DataBaseService{

  final CollectionReference ref = FirebaseFirestore.instance.collection("Order");
   String _ItemTitle = "ItemTitle";
   String _MRP = "MRP";
   String _Price = "Price";
   String _Stock = "Stock";
   String _Category = "Category";
   String _Color = "Color";
   String _Detail = "Detail";
   String _EnableItem = "EnableItem";
   String _Images = "Images";

  // final ref = firebase_

  List<OrderInfo> UserModelData(QuerySnapshot snapshot) {
    List<OrderInfo> ListOfOrder = [];
    List<QueryDocumentSnapshot> docs = snapshot.docs;
    for (QueryDocumentSnapshot d in docs) {
      final single = OrderInfo(
        number: d.id,
        address: d.data()['Address'] ?? "",
        first: d.data()['First'] ?? "jaydip",
        middle: d.data()['Middle'] ?? "",
        last: d.data()['Last'] ?? "",
        city: d.data()['City'] ?? "",
        pincode: d.data()['Pincode'],
        seen: d.data()['seen'] ?? false,
        ItemName: d.data()['ItemName'] ?? "",
        color: d.data()['Color'] ?? "",
         Category: d.data()['Category'] ?? "",
        quantity: d.data()['Quantity'] ?? 0,
         PaidAmmount: d.data()['GivenAmount']??0,
        OrderDate: d.data()['OrderDate']??""
      );
      ListOfOrder.add(single);
    }
    return ListOfOrder;
  }
  
  static Future<void>   setToken(String s) async {
    await FirebaseFirestore.instance.collection("key").doc("key_for_host").update({
      'jay' : s,
    });
  }

  Stream<List<OrderInfo>> get getOrder{
    return ref.snapshots().map(UserModelData);
  }
  Future<String> getImageUrl(String s) async {
    CollectionReference reference = Firestore.instance.collection("SellerProduct");
    final doc = await reference.doc(s).get();
    return doc.data()['Images'][0];
  }
  List<SellerItem> _sellerConverter(QuerySnapshot querySnapshot){
    List<SellerItem> listOfItems = [];
    final docs = querySnapshot.docs;
    if(docs.length > 0){
      for(QueryDocumentSnapshot d in docs){
        final single = SellerItem(
            ItemTitle: d[_ItemTitle],
          MRP: d[_MRP],
          price: d[_Price],
          stock: d[_Stock],
          EnableItem: d[_EnableItem],
          category: d[_Category].toList()

        );
        listOfItems.add(single);
      }
    }
    return listOfItems;

  }

  Stream<List<SellerItem>> get SellerItems{
    return FirebaseFirestore.instance.collection("SellerProduct").snapshots().map(_sellerConverter);
  }
}