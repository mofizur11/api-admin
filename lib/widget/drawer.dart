import 'package:flutter/material.dart';
import 'package:new_admin/widget/brand_colors.dart';
class Drawerr extends StatefulWidget {
  const Drawerr({Key? key}) : super(key: key);

  @override
  _DrawerrState createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 120,
        child: Drawer(
          child: Container(
            //  padding: EdgeInsets.symmetric(horizontal: 20, ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/bg.jpeg"), fit: BoxFit.cover),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,vertical: 30
                  ),
                  width: double.infinity,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                     //   margin: EdgeInsets.only(top: 20),
                        height: 100,
                        width: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80"),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Shirajul Islam",
                        style: myStyle(20, pinkColor, FontWeight.w500),
                      ),
                      Text(
                        "Shirajul@gmail.com",
                        style: myStyle(
                            14, pinkColor, FontWeight.w500),
                      ),
                      SizedBox(height: 16,),
                      Divider(
                        //height: 50,
                        thickness: 1,
                        color: BrandColors.colorPink,
                      ),
                    ],
                  ),
                ),

                Container(
                  // color: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DrawerButton(
                        ontap:  () {
                          Navigator.pop(context);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));
                        },
                        icon:Icon(Icons.home_outlined,color: pinkColor) ,
                        title: "Home",
                      ),
                      DrawerButton(
                        /*ontap:  () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MembershipPage()));
                        },*/
                        icon:Icon(Icons.person_pin_circle_outlined,color: pinkColor) ,
                        title: "Membership",
                      ),
                      DrawerButton(
                        ontap:  () {
                          Navigator.pop(context);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));
                        },
                        icon:Icon(Icons.chat,color: pinkColor) ,
                        title: "Chatroom",
                      ),
                      DrawerButton(
                        /*ontap:  () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));
                        },*/
                        icon:Icon(Icons.account_balance_wallet_outlined,color: pinkColor) ,
                        title: "About Us",
                      ),
                      DrawerButton(
                       /* ontap:  () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs()));
                        },*/
                        icon:Icon(Icons.call,color: pinkColor) ,
                        title: "Contact us",
                      ),
                      DrawerButton(
                        /*ontap:  () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQPage()));
                        },*/
                        icon:Icon(Icons.face_outlined,color: pinkColor) ,
                        title: "FAQ",
                      ),
                      DrawerButton(
                       /* ontap:  () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                        },*/
                        icon:Icon(Icons.face_outlined,color: pinkColor) ,
                        title: "Profile Page",
                      ),
                      DrawerButton(
                        ontap:  () {
                          Navigator.pop(context);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));
                        },
                        icon:Icon(Icons.login_outlined,color: pinkColor) ,
                        title: "Log out",
                      ),


                    ],
                  ),
                )
              ],
            ),
          ),
          elevation: 10,
        ),
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  VoidCallback ?ontap;
  dynamic icon;
  String ?title;
  DrawerButton({this.title,this.ontap,this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:ontap,
      child: Container(
          height: 45,
          child: Row(
            children: [
              icon,
              SizedBox(
                width: 15,
              ),
              Text(
                "${title}", // home
                style: myStyle(16, navyBlueColor,FontWeight.w600),
              ),
            ],
          )),
    );
  }
}
