import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_admin/http/custom_http_request.dart';
import 'package:new_admin/model/category_model.dart';
import 'package:new_admin/provider/category_provider.dart';
import 'package:new_admin/screen/tab_item/category_page.dart';
import 'package:new_admin/widget/brand_colors.dart';
import 'package:new_admin/widget/widget.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';

class EditCategory extends StatefulWidget {
   EditCategory({Key? key,this.categoryModel}) : super(key: key);
  CategoryModel ?categoryModel;

  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {



  TextEditingController? nameController ;
  final _formKey = GlobalKey<FormState>();

  File ?icon, image;
  final picker = ImagePicker();

  bool onProgress = false;

  Future getIconformGallery() async {
    print('on the way of gallery');
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        icon = File(pickedImage.path);
        print('image found');
        print('$icon');
      } else {
        print('no image found');
      }
    });
  }

  Future getImageformGallery() async {
    print('on the way of gallery');
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
        print('image found');
        print('$image');
      } else {
        print('no image found');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    nameController=TextEditingController(text: widget.categoryModel!.name);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return ModalProgressHUD(
      inAsyncCall: onProgress,
      opacity: 0.1,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
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
          title: Text('Add new category'),
          titleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category Name', ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: nameController,

                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*Write Category Name";
                      }
                      if (value.length < 3) {
                        return "*Write more then three word";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            gapPadding: 5.0,
                            borderSide:
                            BorderSide(color: aTextColor, width: 2.5)),
                        hintText: 'Enter Category Name'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Category Icon', ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                 //   overflow: Overflow.visible,
                    children: [
                      Container(
                        height:200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: icon == null
                            ? InkWell(
                          onTap: (){
                            getIconformGallery();

                          },
                          child: Image.network("https://apihomechef.antopolis.xyz/images/${widget.categoryModel!.icon}")
                        )
                            : Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(icon!),
                              )),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    '* 320x320 is the Recommended Size',
                    style: TextStyle(
                        color: Colors.black26,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Category Image', ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    //overflow: Overflow.visible,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.all(Radius.circular(5)),

                        ),
                        child:  image == null
                            ? InkWell(
                          onTap: (){
                            getImageformGallery();

                          },
                            child: Image.network("https://apihomechef.antopolis.xyz/images/${widget.categoryModel!.image}")
                        )
                            : Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(image!),
                              )),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 25,
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
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();


                              //createCategory();
                              updateCategory();


                          }
                        },
                        child: Center(
                          child: Text(
                            'Publish Category',
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
    );
  }


  Future updateCategory() async {
    setState(() {onProgress = true;
    });
    final uri = Uri.parse(
        "https://apihomechef.antopolis.xyz/api/admin/category/${widget.categoryModel!.id}/update");
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(await CustomHttpRequest.getHeaderWithToken(),
    );
    request.fields['name'] = nameController!.text.toString();
    if (image != null) {
      var photo = await http.MultipartFile.fromPath('image', image!.path);
      print('processing');
      request.files.add(photo);
    }
    if (icon != null) {
      var _icon = await http.MultipartFile.fromPath('icon', icon!.path);
      print('processing');
      request.files.add(_icon);}
    var response = await request.send();
    print("status code issssssssssssssssssssss${response.statusCode}");

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var data = jsonDecode(responseString);
    if (response.statusCode == 200) {
      print("responseBody1 $responseData");
      print('oooooooooooooooooooo');
      print(data['message']);
      setState(() {
        onProgress = false;
      });
      showInToast(data['message']);
      Provider.of<CategoriesProvider>(context,listen: false).getCategories(context, onProgress);
      Navigator.pop(context);
      print("${response.statusCode}");
    } else{
      print("responseBody1 $responseString");
      showInToast("Try again please");
      setState(() {
        onProgress = false;
      });
    }
  }
}
