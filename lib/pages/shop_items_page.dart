import 'package:flap_kap/classes/api.dart';
import 'package:flap_kap/classes/shop_item.dart';
import 'package:flap_kap/components/Item.dart';
import 'package:flutter/material.dart';
import 'item_reviews_page.dart';

class ShopItemsPage extends StatefulWidget {
  final List<Api> data;
  const ShopItemsPage(this.data);
  // const ShopItemsPage ({ Key? key, required this.data }): super(key: key);
  @override
  _ShopItemsPageState createState() => _ShopItemsPageState();
}

class _ShopItemsPageState extends State<ShopItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: Text('Purchased Items ',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children:
            widget.data.map((e) => new Item(tags: e.tags, picture: e.picture, price: e.price, isActive: e.isActive, status: e.status, id: e.id, company: e.company, buyer: e.buyer, registered: e.registered,

            )).toList()
          ,
        ));
  }
}

