import 'package:flap_kap/classes/api.dart';
import 'package:flap_kap/classes/shop_item.dart';
import 'package:flap_kap/components/Item.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ShopItemsPage extends StatefulWidget {
  final List<Api> data;

  const ShopItemsPage(this.data);

  // const ShopItemsPage ({ Key? key, required this.data }): super(key: key);
  @override
  _ShopItemsPageState createState() => _ShopItemsPageState();
}

class _ShopItemsPageState extends State<ShopItemsPage> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            PurchasedBody(
              widget: widget,
              type: Status.ORDERED,
            ),
            PurchasedBody(
              widget: widget,
              type: Status.DELIVERED,
            ),
            PurchasedBody(
              widget: widget,
              type: Status.RETURNED,
            ),
            Container(
              color: Colors.white,
              child: Center(child: Text("Nothing here yet"),),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        }),
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Ordered'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.delivery_dining),
            title: Text('Delivered'),
            activeColor: Colors.green,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.keyboard_return),
            title: Text(
              'Returned',
            ),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class PurchasedBody extends StatefulWidget {
  const PurchasedBody({
    Key? key,
    required this.widget,
    required this.type,
  }) : super(key: key);

  final ShopItemsPage widget;
  final Status type;

  @override
  _PurchasedBodyState createState() => _PurchasedBodyState();
}

class _PurchasedBodyState extends State<PurchasedBody> {

  late ScrollController controller;
  int index = 0;
  late List<Api> items = [] ;
  @override
  void initState() {
    super.initState();
    items.addAll(widget.widget.data.getRange(0, 20).toList());

    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }
  void _scrollListener() {
    if(index < widget.widget.data.length){
      print(controller.position.extentAfter);
      if (controller.position.extentAfter < 500 * (index+1)) {
        setState(() {
          items.addAll(widget.widget.data.getRange(index, index + 10).toList());
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return

      Scrollbar(
        child: ListView.builder(
          controller: controller,
          itemCount: items.length,

          itemBuilder: (context, index) {
            if(items[index].status == widget.type){
              return new Item(
                tags: items[index].tags,
                picture: items[index].picture,
                price: items[index].price,
                isActive: items[index].isActive,
                status: items[index].status,
                id: items[index].id,
                company: items[index].company,
                buyer: items[index].buyer,
                registered: items[index].registered,
              );
            }
            else{
              return Container();
            }
          },
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 16.0),

    ),
      );
  }
}
