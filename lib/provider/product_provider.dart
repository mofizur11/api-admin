



import 'package:flutter/cupertino.dart';
import 'package:new_admin/http/custom_http_request.dart';
import 'package:new_admin/model/category_model.dart';
import 'package:new_admin/model/product_model.dart';


class ProductProvider with ChangeNotifier{

  List<ProductModel> productsList = [];

  getProducts(context,bool onProgress) async {
    onProgress = true;
    productsList = await CustomHttpRequest.getProducts(context);
    onProgress = false;
    notifyListeners();
  }
}