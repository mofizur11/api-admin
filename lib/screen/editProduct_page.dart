/*
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_admin/http/custom_http_request.dart';
import 'package:new_admin/model/product_model.dart';
import 'package:new_admin/widget/brand_colors.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class EditProductPage extends StatefulWidget {
  final int ?id;
  final String ?categoryName;
  final int ?categoryId;
  EditProductPage({this.id,this.categoryName,this.categoryId});
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountAmountController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();

  double ?disPrice;
  bool onProgress = false;

  dynamic discountPrice;
  dynamic amount;
  dynamic discount_type ;

  _calcutateFix() {
    if (discount_type == "fixed") {
      setState(() {
        discountPrice = int.parse(
            priceController.text.toString()
        ) - int.parse(discountAmountController.text);
        print('...................................');
        print(discountPrice);
        // discount_type = 'fixed';
      });
    }
    else{
      setState(() {
        discountPrice = (int.parse(
            priceController.text.toString()
        ) / 100) * (100 - int.parse(discountAmountController.text));
        // discountPrice = int.parse(priceController.text.toString()) - price;
        print('.......percent............................');
        print(discountPrice);
        // discount_type = "percent";
      });
    }
  }

  String ?categoryType ;

  List? categoryList;

  Future<dynamic> getCategory() async {
    setState(() {
      onProgress = true;
    });
    await CustomHttpRequest.getCategoriesDropDown().then((responce) {
      var dataa = json.decode(responce.body);
      setState(() {
        categoryList = dataa;
        onProgress = false;
        print("all categories are : $categoryList");
      });
    });
  }


  bool isFixed = true;
  // bool isPercentage = false;
  bool isImageVisiable = false;
  File image;
  final picker = ImagePicker();

  Future getImageformGallery() async {
    print('on the way of gallery');
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
        print('image found');
        print('$image');
        setState(() {
          isImageVisiable = true;
        });
      } else {
        print('no image found');
      }
    });
  }

  ProductModel products =ProductModel();
  initialData() async{
    onProgress = true;

    products = await CustomHttpRequest.getProductEditId(context, widget.id!.toInt());

    setState(() {

      nameController.text = products.name.toString() ;
      //categoryType = products.foodItemCategory[0].name;
      quantityController.text = products.stockItems![0].quantity.toString();
      priceController.text = products.price![0].originalPrice.toString();
      discountAmountController.text = products.price![0].percentOf == null ? products.price![0].fixedValue.toString() : products.price![0].percentOf.toString();
      discountPrice = products.price![0].discountedPrice ?? "";
      discount_type = products.price![0].discountType;
      print('discount type :  $discount_type');

      onProgress = false;
    });
  }

  Future productUpdate(int id) async{
    try{
      setState(() {
        onProgress = true;
      });
      var data;
      final uri =
      Uri.parse(
          "https://apihomechef.antapp.space/api/admin/product/$id/update");
      var request = http.MultipartRequest("POST", uri);
      request.headers.addAll(await CustomHttpRequest.getHeaderWithToken(),
      );
      request.fields['name'] = nameController.text.toString();
      print('name : ');
      print(nameController.text.toString());
      if(categoryType != null){
        request.fields['category_id'] = categoryType.toString();
        print('category_id : ');
        print(categoryType.toString());
      }else{
        request.fields['category_id'] = widget.categoryId.toString();
        print('category_id unchanged: ');
        print(widget.categoryId.toString());
      }

      request.fields['quantity'] = quantityController.text.toString();
      print('quantity : ');
      print(quantityController.text.toString());
      request.fields['original_price'] = priceController.text.toString();
      print('original_price : ');
      print(priceController.text.toString());
      request.fields['discount_type'] = discount_type;
      print('discount_type : ');
      print(discount_type);
      if(discount_type == 'fixed'){
        request.fields['fixed_value'] = discountAmountController.text.toString();
        print('fixed_value : ');
        print(discountAmountController.text.toString());
      }
      else{
        request.fields['percent_of'] = discountAmountController.text.toString();
        print('percent_of : ');
        print(discountAmountController.text.toString());
      }
      request.fields['discounted_price'] = discountPrice.toString();
      print('discounted_price : ');
      print(discountPrice.toString());

      if(image != null){
        var photo = await http.MultipartFile.fromPath('image', image.path);
        print('processing');
        request.files.add(photo);
      }

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("responseBody " + responseString);
      data = jsonDecode(responseString);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("responseBody1 " + responseString);
        data = jsonDecode(responseString);
        //var data = jsonDecode(responseString);
        if(data['message'] != null){
          showInToast(data['message'].toString());
          setState(() {
            onProgress = false;
          });
          //go to the login page
          Navigator.pop(context);

        }
        else{
          showInToast(data['errors']['image'][0]);
          setState(() {
            onProgress = false;
          });
        }

      }
      else{
        showInToast(data['errors']['image'][0]);
        setState(() {
          onProgress = false;
        });
        var errorr = jsonDecode(responseString.trim().toString());
        //showInToast("Registered Failed, please fill all the fields");
        print("Registered failed " + responseString);

      }
    }catch(e){
      print("something went wrong $e");
    }

  }

  showInToast(String value) {
    Fluttertoast.showToast(
        msg: "$value",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: aPrimaryColor,
        textColor: aNavBarColor,
        fontSize: 16.0);
  }

  @override
  void initState() {
    getCategory();
    print(widget.id);
    initialData();
    super.initState();
  }
 */
/* @override
  void didUpdateWidget(DropdownWidget oldWidget) {
    if (this.currentItem != widget.currentItem) {
      setState(() {
        this.currentItem = widget.currentItem;
      });
    }
    super.didUpdateWidget(oldWidget);
  }*//*

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    discountAmountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<EditProductProvider>(context);
    */
/*print("${productData.products.image}");*//*

    //categoryType = "${productData.products.foodItemCategory[0].name ?? ''}";

    final double height = MediaQuery.of(context).size.height;
    final double weidth = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: onProgress,
      opacity: 0.1,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        backgroundColor: aNavBarColor,
        appBar: AppBar(
          backgroundColor: aNavBarColor,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: aTextColor,
            ),
          ),
          title: Text('Edit product'),
          titleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        body:  RawScrollbar(
          thumbColor: aPrimaryColor,
          isAlwaysShown: true,
          thickness: 3.0,
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3, bottom: 0),
                          child: Text(
                            'Category',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          decoration: BoxDecoration(
                              color: aSearchFieldColor,
                              border: Border.all(color: Colors.grey, width: 0.2),
                              borderRadius: BorderRadius.circular(10.0)),
                          height: 60,
                          child: Center(
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                              ),
                              decoration: InputDecoration.collapsed(hintText: ''),
                              value: categoryType,
                              hint: Text(
                                widget.categoryName != null ? widget.categoryName : "Select Category",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: aTextColor, fontSize: 16),
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  categoryType = newValue ??  productData.products.foodItemCategory[0].name.toString();
                                  print("my Category is $categoryType");
                                  */
/*if (categoryType.isEmpty) {
                                    return "Required";
                                  }*//*

                                  // print();
                                });
                              },
                              */
/*validator: (value) =>
                              value == null ? 'field required' : null,*//*

                              items: categoryList?.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(
                                    "${item['name']}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: aTextColor,
                                        fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  value: item['id'].toString(),
                                );
                              })?.toList() ??
                                  [],
                            ),
                          ),
                        ),
                      ],
                    ),


                    SizedBox(
                      height: 20,
                    ),
                    ProductTextField(
                      name: 'Product Name',
                      hint: 'Enter Product name',
                      controller: nameController,
                      validator: (value){
                        if(value.isEmpty){
                          return "*Please give product name";
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    */
/*ProductTextField(
                      name: 'Product Details',
                      hint: 'Write details here...',
                      maxNumber: 5,
                    ),
                    SizedBox(
                      height: 20,
                    ),*//*

                    Row(
                      children: [
                        Expanded(
                          child: ProductTextField(
                            name: 'Quantity(Units)',
                            hint: 'Enter amount',
                            controller: quantityController,
                            validator: (value){
                              if(value.isEmpty){
                                return "*How much product you have";
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: ProductTextField(
                            name: 'Price(BDT)',
                            hint: 'Enter price',
                            controller: priceController,
                            validator: (value){
                              if(value.isEmpty){
                                return "*Please give product price";
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ProductTextField(
                            name: 'Discount Amount',
                            hint: 'Enter amount',
                            controller: discountAmountController,
                            onChange: (value){
                              setState(() {
                                //amount = value;
                                _calcutateFix();
                              });
                            },
                            validator: (value){
                              if(value.isEmpty){
                                return "*Please give discount";
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Discount Price",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      border:
                                      Border.all(color: aTextColor, width: 0.5)),
                                  child: Text(
                                    '${discountPrice ?? "Discount price"}',
                                    style: TextStyle(fontSize: 16, color: aTextColor),
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      // padding: EdgeInsets.symmetric(
                      //     horizontal: 10,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add Discount',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // isFixed = true;
                                    discount_type = "fixed";
                                    _calcutateFix();
                                  });
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          color:
                                          discount_type == "fixed" ? aTextColor : aNavBarColor,
                                          border: Border.all(color: aTextColor),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: Center(
                                            child: Icon(
                                              Icons.check,
                                              size: 12,
                                              color: aNavBarColor,
                                            )),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Fixed Discount',
                                        style: TextStyle(
                                          color: discount_type == "fixed"
                                              ? Colors.black
                                              : Colors.black45,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // isPercentage = !isPercentage;
                                    // isFixed = false;
                                    discount_type = "percent";
                                    _calcutateFix();
                                  });
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          color: discount_type.toString() == "percent"
                                              ? aTextColor
                                              : aNavBarColor,
                                          border: Border.all(color: aTextColor),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: Center(
                                            child: Icon(
                                              Icons.check,
                                              size: 12,
                                              color: aNavBarColor,
                                            )),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Percentage Discount',
                                        style: TextStyle(
                                          color: discount_type == "percent"
                                              ? Colors.black
                                              : Colors.black45,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Product Image', style: editPageTextStyle),
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      overflow: Overflow.visible,
                      children: [
                        Container(
                          height: height * 0.3,
                          width: weidth * 0.9,
                          decoration: BoxDecoration(
                            color: aPrimaryColor,
                            border: Border.all(color: aTextColor, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: image == null ?
                              NetworkImage(
                                "https://homechef.antapp.space/images/${products.image}",
                              ) : FileImage(image),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -25,
                          left: weidth * 0.4,

                          child: TextButton(
                            onPressed: () {
                              getImageformGallery();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(50)),
                                  color: Colors.black,
                                  border: Border.all(
                                      color: aNavBarColor, width: 1.5)),
                              child: Center(
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: SvgPicture.asset(
                                      "assets/image_logo.svg"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      '* 640x360 is the Recommended Size',
                      style: TextStyle(
                          color: Colors.black26,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.black,
                          border: Border.all(color: aTextColor, width: 0.5),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                             // showInToast('Please select product category');
                              _formKey.currentState.save();
                              */
/*if(image == null){
                                showInToast('Please select product image');
                              }else{
                                productUpdate(widget.id);
                              }*//*

                              productUpdate(widget.id);

                            }
                            else{
                              showInToast('Please select product category');
                            }

                          },
                          child: Center(
                            child: Text(
                              'Update Product',
                              style: TextStyle(
                                  color: aPrimaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
*/
