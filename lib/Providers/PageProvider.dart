import 'package:flutter/cupertino.dart';
enum pages{
  Items,
  Orders,
}

class PageProvider extends ChangeNotifier{
  pages currentPage = pages.Items;
  void setCurrentPage(pages current){
    this.currentPage = current;
    notifyListeners();
  }
}