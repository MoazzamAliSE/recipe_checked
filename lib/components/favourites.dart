// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../main.dart';
//
// class Favourites extends StatefulWidget{
//   final String title;
//   final String id;
//
//   Favourites({this.title, this.id})
//
//   @override
//   _FavouritesState createState() => _FavouritesState();
// }
//
// class _FavouritesState extends State<Favourites> {
//   bool _visibilityTag = true;
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addObserver(
//         new LifecycleEventHandler(resumeCallBack: () async => _refreshContent()));
//   }
//
//   _refreshContent() {
//     setState(() {
//       // Here you can change your widget
//       // each time the app resumed.
//       var now = DateTime.now();
//
//     });
//   }
//
//   _deleteConfirmation(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Are you sure you want to unfavourite this recipe?",
//                 style: Theme.of(context).textTheme.bodyText2),
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   MaterialButton(
//                       child: Text('cancel'),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       }),
//                   MaterialButton(
//                       child: Text('ok'),
//                       onPressed: () {
//                         // delete ingredient from db
//                         setState(() {
//                           _visibilityTag = false;
//                         });
//                         Navigator.pop(context);
//                       }),
//                 ],
//               )
//             ],
//           );
//         });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//         child: Row(
//         children: <Widget>[
//           Text(widget.title, style: TextStyle(fontSize: 12, color: Colors.black),
//
//             ),
//
//         ],  ),);
//     }
// }
