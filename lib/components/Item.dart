import 'dart:math';

import 'package:flap_kap/classes/api.dart';
import 'package:flap_kap/pages/item_reviews_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Item extends StatelessWidget {
  final String id;
  final bool isActive;
  final String price;
  final String company;
  final String picture;
  final String buyer;
  final List<String> tags;
  final Status status;
  final String registered;
  const Item ({ Key? key, required this.id, required  this.isActive, required this.price, required this.company,required  this.picture,required  this.buyer,required   this.tags,required  this.status,required  this.registered }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Stack(
        children: <Widget>[
          /// Item card
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox.fromSize(
                size: Size.fromHeight(172.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    /// Item description inside a material
                    Container(
                      margin: EdgeInsets.only(top: 24.0),
                      child: Material(
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(12.0),
                        shadowColor: Color(0x802196F3),
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {

                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => ItemReviewPage(
                                      tags: this.tags,
                                      picture: this.picture,
                                      price: this.price,
                                      isActive: this.isActive,
                                      status: this.status,
                                      id: this.id,
                                      company: this.company,
                                      buyer: this.buyer,
                                      registered: this.registered,
                                    ),)

                            );
                          },

                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                /// Title and rating
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('${this.company}',
                                        style: TextStyle(
                                            color: Colors.blueAccent)),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text('${this.price}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 34.0)),
                                        Icon(Icons.monetization_on_outlined,
                                            color: Colors.black, size: 24.0),
                                      ],
                                    ),
                                  ],
                                ),

                                /// Infos
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Bought', style: TextStyle()),
                                    Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Text('1,361',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                    ),
                                    Text('times for a profit of',
                                        style: TextStyle()),
                                    Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Material(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        color: Colors.green,
                                        child: Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Text('\$ 13K',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// Item image
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(54.0),
                          child: Material(
                            elevation: 20.0,
                            shadowColor: Color(0x802196F3),
                            shape: CircleBorder(),
                            child: Image.network('${this.picture}'),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),

          /// Review
          Padding(
            padding: EdgeInsets.only(top: 160.0, left: 32.0),
            child: Material(
              elevation: 12.0,
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: this.status == Status.RETURNED ? [Colors.red , Colors.purpleAccent] : this.status == Status.DELIVERED ? [  Color(0xFF84fab0), Color(0xFF8fd3f4)] : [Colors.blue , Colors.blueAccent],
                        end: Alignment.topLeft,
                        begin: Alignment.bottomRight)),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                      child: Text('${getInitials(this.buyer)}', style: TextStyle(color: Colors.white)),
                    ),
                    title: Text('${this.buyer}'),
                    subtitle: Text(
                        'Item status : ${this.status}\nActive Status: ${this.isActive}, Registered Status: ${this.registered}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle()),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(' ').map((l) => l[0]).take(2).join()
      : '';
}



// class BadShopItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 16.0),
//       child: Stack(
//         children: <Widget>[
//           /// Item card
//           Align(
//             alignment: Alignment.topCenter,
//             child: SizedBox.fromSize(
//                 size: Size.fromHeight(172.0),
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: <Widget>[
//                     /// Item description inside a material
//                     Container(
//                       margin: EdgeInsets.only(top: 24.0),
//                       child: Material(
//                         elevation: 14.0,
//                         borderRadius: BorderRadius.circular(12.0),
//                         shadowColor: Color(0x802196F3),
//                         color: Colors.transparent,
//                         child: Container(
//                           decoration: BoxDecoration(
//                               gradient: LinearGradient(colors: [
//                                 Color(0xFFDA4453),
//                                 Color(0xFF89216B)
//                               ])),
//                           child: Padding(
//                             padding: EdgeInsets.all(24.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 /// Title and rating
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text('Nike Jordan III',
//                                         style: TextStyle(color: Colors.white)),
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.center,
//                                       children: <Widget>[
//                                         Text('1.3',
//                                             style: TextStyle(
//                                                 color: Colors.amber,
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 34.0)),
//                                         Icon(Icons.star,
//                                             color: Colors.amber, size: 24.0),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//
//                                 /// Infos
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: <Widget>[
//                                     Text('Bought',
//                                         style: TextStyle(color: Colors.white)),
//                                     Padding(
//                                       padding:
//                                       EdgeInsets.symmetric(horizontal: 4.0),
//                                       child: Text('3',
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.w700)),
//                                     ),
//                                     Text('times for a profit of',
//                                         style: TextStyle(color: Colors.white)),
//                                     Padding(
//                                       padding:
//                                       EdgeInsets.symmetric(horizontal: 4.0),
//                                       child: Material(
//                                         borderRadius:
//                                         BorderRadius.circular(8.0),
//                                         color: Colors.green,
//                                         child: Padding(
//                                           padding: EdgeInsets.all(4.0),
//                                           child: Text('\$ 363',
//                                               style: TextStyle(
//                                                   color: Colors.white)),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     /// Item image
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 16.0),
//                         child: SizedBox.fromSize(
//                           size: Size.fromRadius(54.0),
//                           child: Material(
//                             elevation: 20.0,
//                             shadowColor: Color(0x802196F3),
//                             shape: CircleBorder(),
//                             child: Image.asset('assets/images/shoes1.png'),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )),
//           ),
//
//           /// Review
//           Padding(
//             padding: EdgeInsets.only(
//               top: 160.0,
//               right: 32.0,
//             ),
//             child: Material(
//               elevation: 12.0,
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(20.0),
//                 bottomLeft: Radius.circular(20.0),
//                 bottomRight: Radius.circular(20.0),
//               ),
//               child: Container(
//                 margin: EdgeInsets.symmetric(vertical: 4.0),
//                 child: ListTile(
//                   leading: CircleAvatar(
//                     backgroundColor: Colors.purple,
//                     child: Text('AI'),
//                   ),
//                   title: Text('Ivascu Adrian ★☆☆☆☆'),
//                   subtitle: Text(
//                       'The shoes that arrived weren\'t the same as the ones in the image...',
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class NewShopItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 16.0),
//       child: Align(
//         alignment: Alignment.topCenter,
//         child: SizedBox.fromSize(
//             size: Size.fromHeight(172.0),
//             child: Stack(
//               fit: StackFit.expand,
//               children: <Widget>[
//                 /// Item description inside a material
//                 Container(
//                   margin: EdgeInsets.only(top: 24.0),
//                   child: Material(
//                     elevation: 14.0,
//                     borderRadius: BorderRadius.circular(12.0),
//                     shadowColor: Color(0x802196F3),
//                     color: Colors.white,
//                     child: Padding(
//                       padding: EdgeInsets.all(24.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           /// Title and rating
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text('[New] Nike Jordan III',
//                                   style: TextStyle(color: Colors.blueAccent)),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: <Widget>[
//                                   Text('No reviews',
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 34.0)),
//                                 ],
//                               ),
//                             ],
//                           ),
//
//                           /// Infos
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               Text('Bought', style: TextStyle()),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 4.0),
//                                 child: Text('0',
//                                     style:
//                                     TextStyle(fontWeight: FontWeight.w700)),
//                               ),
//                               Text('times for a profit of', style: TextStyle()),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 4.0),
//                                 child: Material(
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   color: Colors.green,
//                                   child: Padding(
//                                     padding: EdgeInsets.all(4.0),
//                                     child: Text('\$ 0',
//                                         style: TextStyle(color: Colors.white)),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 /// Item image
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: Padding(
//                     padding: EdgeInsets.only(right: 16.0),
//                     child: SizedBox.fromSize(
//                       size: Size.fromRadius(54.0),
//                       child: Material(
//                         elevation: 20.0,
//                         shadowColor: Color(0x802196F3),
//                         shape: CircleBorder(),
//                         child: Image.asset('assets/images/shoes1.png'),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )),
//       ),
//     );
//   }
// }
