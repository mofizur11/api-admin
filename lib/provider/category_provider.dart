

import 'package:flutter/cupertino.dart';
import 'package:new_admin/http/custom_http_request.dart';
import 'package:new_admin/model/category_model.dart';


class CategoriesProvider with ChangeNotifier{

  List<CategoryModel> categoriesList = [];

  getCategories(context,bool onProgress) async {
    onProgress = true;
    categoriesList = await CustomHttpRequest.getCategories(context);
    onProgress = false;
    notifyListeners();
  }
}