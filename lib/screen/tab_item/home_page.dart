import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; 
import 'package:new_admin/provider/order_provider.dart';
import 'package:new_admin/widget/brand_colors.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool onProgress = false;

  @override
  void initState() {
    // TODO: implement initState
      Provider.of<OrderProvider>(context, listen: false).getRecentOrders(context);
    super.initState();}
  @override
  Widget build(BuildContext context) {
    final recentOrders = Provider.of<OrderProvider>(context);
    return Scaffold(backgroundColor: aBackgroundColor,
        body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      child: Row(
                        children: [
                          Text('Recent Orders'),
                          Spacer(),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      height: MediaQuery.of(context).size.width * 1,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child:
                      recentOrders.orderList.isNotEmpty ? NotificationListener<UserScrollNotification>(
                        onNotification: (notification){
                          setState(() {
                            if(notification.direction == ScrollDirection.forward){
                              showFav = true;
                            }
                            else if(notification.direction == ScrollDirection.reverse){
                              showFav = false;
                            }
                          });
                          return true;
                        },
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: recentOrders.orderList.length  ,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: Row(
                                  children: [
                                    Icon(
                                      recentOrders.orderList[index].payment!.paymentStatus.toString() == '1'?
                                      Icons.check_circle_outlined:Icons.access_time_rounded,
                                      color: recentOrders.orderList[index].payment!.paymentStatus.toString() == '1'? Colors.green :aPrimaryColor,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${recentOrders.orderList[index].user!.name ?? ""}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          '#${recentOrders.orderList[index].id ?? ""}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      '\৳ ${recentOrders.orderList[index].price ?? ""}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: aPriceTextColor),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ): Center(child: CircularProgressIndicator()),
                    )
                  ],
                ),

                /* child: */
              )
            ],
          ),
        ),
      ),

    );



  }
  bool showFav = true;
}
