import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:new_admin/model/category_model.dart';
import 'package:new_admin/model/order_model.dart';
import 'package:new_admin/model/order_model_home.dart';
import 'package:new_admin/model/product_model.dart';
import 'package:new_admin/widget/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CustomHttpRequest{
  static const String uri = "https://apihomechef.antapp.space";
  static const Map<String, String> defaultHeader = {
    "Accept": "application/json",
    "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpaG9tZWNoZWYuYW50b3BvbGlzLnh5elwvYXBpXC9hZG1pblwvc2lnbi1pbiIsImlhdCI6MTY1NDAwNzYwNiwiZXhwIjoxNjY2OTY3NjA2LCJuYmYiOjE2NTQwMDc2MDYsImp0aSI6IjlLWGFGNmRFdlgwWVNZVzIiLCJzdWIiOjUwLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.Cbii274lgjkMIf2Ix9fZ7e8HPAT47B5MV0QP03Rd520",
  };

  static const Map<String, String> defaultHeader2 = {
    "Accept": "application/json",
    "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpaG9tZWNoZWYuYW50b3BvbGlzLnh5elwvYXBpXC9hZG1pblwvc2lnbi1pbiIsImlhdCI6MTY1NDAwNzYwNiwiZXhwIjoxNjY2OTY3NjA2LCJuYmYiOjE2NTQwMDc2MDYsImp0aSI6IjlLWGFGNmRFdlgwWVNZVzIiLCJzdWIiOjUwLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.Cbii274lgjkMIf2Ix9fZ7e8HPAT47B5MV0QP03Rd520",
  };
  static SharedPreferences ?sharedPreferences;

  static Future<Map<String, String>> getHeaderWithToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var header = {
      "Accept": "application/json",
      "Authorization": "bearer ${sharedPreferences!.getString("token")}",
    };
    print("user token is :${sharedPreferences!.getString('token')}");
    return header;
  }


  static Future<Map<String, String>> getHeaderWithToken2() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var header = {
      "Content-type": "application/json",
      "Authorization": "bearer ${sharedPreferences!.getString("token")}",
    };
    print("user token is :${sharedPreferences!.getString('token')}");
    return header;
  }
  static Future<dynamic> getOrder(context) async{
    OrderModel orders;
    List<OrderModel> orderList = [];
    try{
      String url = "https://apihomechef.antopolis.xyz/api/admin/all/orders";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      print(response.statusCode);
      if(response.statusCode == 200){
        final item = json.decode(response.body);
        print(item);
        for(var i in item){
          orders = OrderModel.fromJson(i);
          orderList.add(orders);
          print("orders: $orderList");
        }

      }
      else{
        print('Data not found');
      }
    } catch(e){
      print(e);
    }
    return orderList;
  }



  static Future<dynamic> getCategories(context) async{
    CategoryModel categories;
    List<CategoryModel> categoriesList = [];
    try{
      String url = "https://apihomechef.antopolis.xyz/api/admin/category";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      if(response.statusCode == 200){

        final item = json.decode(response.body);
        print(item);
        for(var i in item){
          categories = CategoryModel.fromJson(i);
          categoriesList.add(categories);
        }

      }
      else{
        print('Data not found');
      }
    } catch(e){
      print(e);
    }
    return categoriesList;
  }


  static Future<dynamic> getProducts(context) async{
    ProductModel productModel;
    List<ProductModel> productList = [];
    try{
      String url = "https://apihomechef.antopolis.xyz/api/admin/products";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      if(response.statusCode == 200){

        final item = json.decode(response.body);
        print(item);
        for(var i in item){
          productModel = ProductModel.fromJson(i);
          productList.add(productModel);
        }

      }
      else{
        print('Data not found');
      }
    } catch(e){
      print(e);
    }
    return productList;
  }


  static Future<bool> deleteCategoryItem(BuildContext context,int id)async{
    try{
      print("id is ${id}");
      String url = "https://apihomechef.antopolis.xyz/api/admin/category/$id/delete";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.delete(
          myUri,headers: await getHeaderWithToken()
      );
      final data = jsonDecode(response.body);
      print(data.toString());

      if(response.statusCode==200){
        print(data['message'].toString());
        showInToast('${data['message']}');
        return true;
      }
      else{
        //throw Exception("Can't delete ");
        return false;
      }
    }catch(e){
      print(e);
      return false;
    }
  }

  //for dropdownButton
  static Future<dynamic> getCategoriesDropDown() async {
    try {
      String url = "https://apihomechef.antopolis.xyz/api/admin/category";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      if (response.statusCode == 200) {
        print(response);
        return response;
      } else
        return "Error";
    } catch (e) {
      print(e);
      return "Something Wrong...!!!";
    }

  }



  static Future<ProductModel> getProductEditId(context,int id) async {
    late ProductModel products;
    try {
      String url = "https://apihomechef.antopolis.xyz/api/admin/product/$id/edit/";
      Uri myUri = Uri.parse(url);
      var response = await http.get(
          myUri, headers: await CustomHttpRequest.getHeaderWithToken()
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print(item);
        products = ProductModel.fromJson(item);
      } else {
        print('Data not found');

      }
    } catch (e) {
      print(e);
    }
    return products;

  }




  static Future<Order> getOrderWithId(context,int id) async {
    Order ?order;
    try {
      String url = "https://apihomechef.antopolis.xyz/api/admin/order/$id/invoice";
      Uri myUri = Uri.parse(url);
      var response = await http.get(
          myUri, headers: await CustomHttpRequest.getHeaderWithToken()
      );
      print("Status code issssssssssssssssssss${response.statusCode}");
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print(item);
        print('data found');
        order = Order.fromJson(item);

        print(order);
      } else {
        print('Data not found');

      }
    } catch (e) {
      print(e);
    }
    return order!;

  }


  static Future<dynamic> deleteOrderItem(BuildContext context,int id,bool onProgress)async{
    try{
      onProgress = true;
      print(id.toString());
      String url = "https://apihomechef.antopolis.xyz/api/admin/order/$id/delete";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.delete(
          myUri,headers: await getHeaderWithToken()
      );
      final data = jsonDecode(response.body);
      print(data.toString());
      print(response.statusCode);
      if(response.statusCode==200){
        print(data);
        print("delete sucessfully");
        print(data['message'].toString());
        onProgress = false;
        showInToast("context,'${data['message']}");
        return response;

      }
      else{
        onProgress = false;
        throw Exception("Can't delete ");
      }
    }catch(e){
      onProgress = false;
      print(e);
    }
  }




  static Future<dynamic> getProductDropDown() async {
    try {
      String url = "https://apihomechef.antopolis.xyz/api/admin/products";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      if (response.statusCode == 200) {
        print(response);
        return response;
      } else
        return "Error";
    } catch (e) {
      print(e);
      return "Something Wrong...!!!";
    }

  }


  static Future<dynamic> getUsersDropDown() async {
    try {
      String url = "https://apihomechef.antopolis.xyz/api/admin/all/user";
      Uri myUri = Uri.parse(url);
      http.Response response = await http.get(
          myUri,headers: await getHeaderWithToken()
      );
      if (response.statusCode == 200) {
        print(response);
        return response;
      } else
        return "Error";
    } catch (e) {
      print(e);
      return "Something Wrong...!!!";
    }

  }

}


