import 'package:flutter/material.dart';
import 'package:new_admin/widget/brand_colors.dart';



class Model {
  final String ?svgSrc, title, totalStorage, img, type, delay,details2,email,taskName;
  final int ?id, percentage;
  final Color ?color;
  final IconData ?icon;
  final String ?details;
  final String ?time;

  Model({
    this.taskName,
    this.details,
    this.email,
    this.delay,
    this.details2,
    this.time,
    this.icon,
    this.type,
    this.img,
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.id,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  Model(
      delay: "4h",
      taskName:"Web Design",
      email: "mitu@gmail.com",
      details: "Conversely, many high-end blogs in the marketing space consistently ",
      type: "Assigned",
      time: "3.03 pm",
      title: "Limon bhai",
      details2:"words for just about everything I write and often try to exceed that. Some of my posts are over 4,000 words on deeper and more competitive topics" ,
      id: 1328,
      svgSrc: "assets/icons/Documents.svg",
      totalStorage: "2000",
      color: primaryColor,
      percentage: 35,
      icon: Icons.file_present,
      img:
      "https://i.pinimg.com/originals/91/79/16/917916eff63ddbc417699af70e568c67.jpg"),
  Model(
      type: "Open",
      taskName:"App Development",
      email: "pranto@gmail.com",
      details: "words for just about everything I write and often try to exceed that. Some of my posts are over 4,000 words on deeper and more competitive topics.",
      time: "3.20 pm",
      title: "Waliur bhai",
      id: 56,
      delay: "2h",
      details2:"words for just about everything I write and often try to exceed that. Some of my posts are over 4,000 words on deeper and more competitive topics" ,
      svgSrc: "assets/icons/google_drive.svg",
      totalStorage: "200",
      color: Color(0xFFFFA113),
      percentage: 35,
      icon: Icons.drive_folder_upload,
      img: "https://i.pinimg.com/originals/ce/41/3a/ce413a47d51387bb4e111bf99ef38167.jpg"),
  Model(
      time: "6.13 pm",
      taskName:"Web Testing",
      icon: Icons.zoom_out_map,
      details: "examine definitions for terms used throughout a post. In this case, since I’m talking about long-form and short-form content, we should define what we mean by that.",
      title: "Shirajul Islam",
      delay: "4h",
      id: 132,
      type: "Assigned",
      email: "pranto@gmail.com",
      details2:"words for just about everything I write and often try to exceed that. Some of my posts are over 4,000 words on deeper and more competitive topics" ,
      svgSrc: "assets/icons/one_drive.svg",
      totalStorage: "420",
      color: Color(0xFFA4CDFF),
      percentage: 10,
      img:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSocB0cZE0xG9j6_mlqsUYt6iXmvg-a-Gy9ag&usqp=CAU"),
  Model(
      time: "3.03 pm",
      taskName:"FeedBack Solve",
      details: "Honestly, a short blog post with a handful of deep videos embedded in them and an infographic to round it up sounds like long-form content to me, even if the actual word count is lower.",
      icon: Icons.wifi_tethering,
      title: "Abir bhai",
      id: 15,
      delay: "4h",
      details2:"words for just about everything I write and often try to exceed that. Some of my posts are over 4,000 words on deeper and more competitive topics" ,
      type: "Open",
      svgSrc: "assets/icons/drop_box.svg",
      totalStorage: "7.3GB",
      email: "pranto@gmail.com",
      color: Color(0xFF007EE5),
      percentage: 78,
      img:
      "https://thumbs.dreamstime.com/b/composite-image-romantic-couple-embracing-against-print-84941989.jpg"),
  Model(
      time: "13.60 pm",
      taskName:"Order Order",
      details: "What is The Point of Diminishing Returns with Blog Word Count?",
      delay: "4h",
      icon: Icons.wifi_tethering,
      title: "Sheehan bhai",
      id: 15,
      details2:"words for just about everything I write and often try to exceed that. Some of my posts are over 4,000 words on deeper and more competitive topics" ,
      type: "Assigned",
      svgSrc: "assets/icons/drop_box.svg",
      totalStorage: "7.3GB",
      email: "pranto@gmail.com",
      color: Color(0xFF007EE5),
      percentage: 78,
      img:
      "https://fbcoverstreet.com/thumbnail/6XEakuKwgAvYcCYG8sIrheqPWmkEEUjBYH6W2xQzKI8bw7I1PK1J3BDbpyD8JGsL.webp"),
  Model(
      delay: "4h",
      taskName:"Web Design",
      email: "mitu@gmail.com",
      details: "Conversely, many high-end blogs in the marketing space consistently ",
      type: "Assigned",
      time: "3.03 pm",
      title: "Limon bhai",
      details2:"words for just about everything I write and often try to exceed that. Some of my posts are over 4,000 words on deeper and more competitive topics" ,
      id: 1328,
      svgSrc: "assets/icons/Documents.svg",
      totalStorage: "2000",
      color: primaryColor,
      percentage: 35,
      icon: Icons.file_present,
      img:
      "https://i.pinimg.com/originals/91/79/16/917916eff63ddbc417699af70e568c67.jpg"),
  Model(
      delay: "4h",
      taskName:"Web Design",
      email: "mitu@gmail.com",
      details: "Conversely, many high-end blogs in the marketing space consistently ",
      type: "Assigned",
      time: "3.03 pm",
      title: "Limon bhai",
      details2:"words for just about everything I write and often try to exceed that. Some of my posts are over 4,000 words on deeper and more competitive topics" ,
      id: 1328,
      svgSrc: "assets/icons/Documents.svg",
      totalStorage: "2000",
      color: primaryColor,
      percentage: 35,
      icon: Icons.file_present,
      img:
      "https://i.pinimg.com/originals/91/79/16/917916eff63ddbc417699af70e568c67.jpg"),
  Model(
      type: "Open",
      taskName:"App Development",
      email: "pranto@gmail.com",
      details: "words for just about everything I write and often try to exceed that. Some of my posts are over 4,000 words on deeper and more competitive topics.",
      time: "3.20 pm",
      title: "Waliur bhai",
      id: 56,
      delay: "2h",
      details2:"words for just about everything I write and often try to exceed that. Some of my posts are over 4,000 words on deeper and more competitive topics" ,
      svgSrc: "assets/icons/google_drive.svg",
      totalStorage: "200",
      color: Color(0xFFFFA113),
      percentage: 35,
      icon: Icons.drive_folder_upload,
      img: "https://i.pinimg.com/originals/ce/41/3a/ce413a47d51387bb4e111bf99ef38167.jpg"),
  Model(
      time: "6.13 pm",
      taskName:"Web Testing",
      icon: Icons.zoom_out_map,
      details: "examine definitions for terms used throughout a post. In this case, since I’m talking about long-form and short-form content, we should define what we mean by that.",
      title: "Shirajul Islam",
      delay: "4h",
      id: 132,
      type: "Assigned",
      email: "pranto@gmail.com",
      details2:"words for just about everything I write and often try to exceed that. Some of my posts are over 4,000 words on deeper and more competitive topics" ,
      svgSrc: "assets/icons/one_drive.svg",
      totalStorage: "420",
      color: Color(0xFFA4CDFF),
      percentage: 10,
      img:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSocB0cZE0xG9j6_mlqsUYt6iXmvg-a-Gy9ag&usqp=CAU"),
  Model(
      time: "3.03 pm",
      taskName:"FeedBack Solve",
      details: "Honestly, a short blog post with a handful of deep videos embedded in them and an infographic to round it up sounds like long-form content to me, even if the actual word count is lower.",
      icon: Icons.wifi_tethering,
      title: "Abir bhai",
      id: 15,
      delay: "4h",
      details2:"words for just about everything I write and often try to exceed that. Some of my posts are over 4,000 words on deeper and more competitive topics" ,
      type: "Open",
      svgSrc: "assets/icons/drop_box.svg",
      totalStorage: "7.3GB",
      email: "pranto@gmail.com",
      color: Color(0xFF007EE5),
      percentage: 78,
      img:
      "https://thumbs.dreamstime.com/b/composite-image-romantic-couple-embracing-against-print-84941989.jpg"),
  Model(
      time: "13.60 pm",
      taskName:"Order Order",
      details: "What is The Point of Diminishing Returns with Blog Word Count?",
      delay: "4h",
      icon: Icons.wifi_tethering,
      title: "Sheehan bhai",
      id: 15,
      details2:"words for just about everything I write and often try to exceed that. Some of my posts are over 4,000 words on deeper and more competitive topics" ,
      type: "Assigned",
      svgSrc: "assets/icons/drop_box.svg",
      totalStorage: "7.3GB",
      email: "pranto@gmail.com",
      color: Color(0xFF007EE5),
      percentage: 78,
      img:
      "https://fbcoverstreet.com/thumbnail/6XEakuKwgAvYcCYG8sIrheqPWmkEEUjBYH6W2xQzKI8bw7I1PK1J3BDbpyD8JGsL.webp"),

];


List<MaterialColor> colorItems=[
Colors.green,Colors.deepOrange,Colors.red,Colors.yellow
];

List <Color> clrList=[
  BrandColors.colorPurple,
  BrandColors.colorGreen,
];