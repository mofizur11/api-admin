import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_admin/http/custom_http_request.dart';
import 'package:new_admin/provider/category_provider.dart';
import 'package:new_admin/screen/add_category.dart';
import 'package:new_admin/screen/edit_category.dart';
import 'package:new_admin/widget/brand_colors.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool onProgress = false;

  var _controller = ScrollController();
  bool _buttonVisiable = true;
  ScrollController? _scrollController;

  @override
  void initState() {
    final categoriesData =
        Provider.of<CategoriesProvider>(context, listen: false)
            .getCategories(context, onProgress);
    _scrollController = ScrollController();
    super.initState();
  }

  String? name = "ppppp";
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoriesProvider>(context).categoriesList;
    final cat = Provider.of<CategoriesProvider>(context);

    return Scaffold(
      body: Container(
          width: double.infinity,
          child: categories.isNotEmpty
              ? NotificationListener<UserScrollNotification>(
                  onNotification: (notification) {
                    setState(() {
                      if (notification.direction == ScrollDirection.forward) {
                        _buttonVisiable = true;
                      } else if (notification.direction ==
                          ScrollDirection.reverse) {
                        _buttonVisiable = false;
                      }
                    });
                    return true;
                  },
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 200,
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://apihomechef.antopolis.xyz/images/${categories[index].image ?? ""}"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${categories[index].name ?? ""}',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                width: 0.1),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(5)),
                                          ),
                                          child: TextButton(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  size: 15,
                                                  color: aTextColor,
                                                ),
                                                Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                    color: aTextColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditCategory(
                                                            categoryModel:
                                                                categories[
                                                                    index],
                                                          )));
                                              /*Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (context) {
                                              return CategoryEditPage(
                                                id: categories
                                                    .categoriesList[index].id,
                                                index: index,
                                                name: categories.categoriesList[index].name,
                                              );
                                            })).then((value) => categories.getCategories(context,onProgress));*/
                                            },
                                          ),
                                        )),
                                        Container(
                                          height: 30,
                                          width: 0.5,
                                          color: Colors.grey,
                                        ),
                                        Expanded(
                                            child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                width: 0.1),
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(5)),
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Are you sure ?'),
                                                      titleTextStyle: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: aTextColor),
                                                      titlePadding:
                                                          EdgeInsets.only(
                                                              left: 35,
                                                              top: 25),
                                                      content: Text(
                                                          'Once you delete, the item will gone permanently.'),
                                                      contentTextStyle:
                                                          TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  aTextColor),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 35,
                                                              top: 10,
                                                              right: 40),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                border: Border.all(
                                                                    color:
                                                                        aTextColor,
                                                                    width:
                                                                        0.2)),
                                                            child: Text(
                                                              'CANCEL',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      aTextColor),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .redAccent
                                                                  .withOpacity(
                                                                      0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5)),
                                                            ),
                                                            child: Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      aPriceTextColor),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            CustomHttpRequest.deleteCategoryItem(
                                                                    context,
                                                                    categories[
                                                                            index]
                                                                        .id!
                                                                        .toInt())
                                                                .then(
                                                                    (value) =>
                                                                        () {
                                                                          setState(
                                                                              () {
                                                                            categories.removeAt(index);
                                                                            Navigator.pop(context);
                                                                            //categories.removeWhere((element) => element.id==categories[index].id);
                                                                          });
                                                                        });

                                                            CustomHttpRequest
                                                                .deleteCategoryItem(
                                                                    context,
                                                                    categories[
                                                                            index]
                                                                        .id!
                                                                        .toInt());
                                                            setState(() {
                                                              categories
                                                                  .removeAt(
                                                                      index);
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  size: 15,
                                                  color: Colors.red,
                                                ),
                                                Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                right: 55,
                                top: 80,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: aTextColor, width: 0.5)),
                                  child: Center(
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://apihomechef.antopolis.xyz/images/${categories[index].icon ?? ""}"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        ;
                      }),
                )
              : CircularProgressIndicator()),
      floatingActionButton: _buttonVisiable
          ? FloatingActionButton(
              onPressed: () {
                /*   Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddCategory())).then((value) => categories.getCategories(context,onProgress));
        */
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddCategory()))
                    .then((value) => cat.getCategories(context, onProgress));
              },
              backgroundColor: aBlackCardColor,
              child: Icon(
                Icons.add,
                size: 30,
                color: aPrimaryColor,
              ),
            )
          : null,
    );
  }
}
