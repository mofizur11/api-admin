
import 'package:flutter/cupertino.dart';
import 'package:new_admin/http/custom_http_request.dart';
import 'package:new_admin/model/order_model_home.dart';

class OrderProvider with ChangeNotifier{

  //Orders orders = Orders();
  List<OrderModel> orderList = [];
  bool onProgress = false;

  getRecentOrders(context) async {
    onProgress = true;
    orderList = await CustomHttpRequest.getOrder(context);
    onProgress = false;
    notifyListeners();
  }
}