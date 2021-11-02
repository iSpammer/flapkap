import 'dart:convert';

import 'package:flap_kap/classes/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'shop_items_page.dart';
import 'package:fl_chart/fl_chart.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String jsonData = "";
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  Future<String> loadData() async {
    return DefaultAssetBundle.of(context).loadString("assets/orders.json");
  }


  static final List<String> chartDropdownItems = [
    'Last 7 days',
    'Last month',
    'Last year'
  ];
  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          title: Text('Dashboard',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 30.0)),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('flapkap.com',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0)),
                  Icon(Icons.arrow_drop_down, color: Colors.black54)
                ],
              ),
            )
          ],
        ),
        body: FutureBuilder(
          future: loadData(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              var dataStr = snapshot.data;
              double avg_price = 0;
              double sum = 0;
              int isActive = 0;
              List<Api> datas = List<Api>.from(
                  json.decode(dataStr!).map((x) => Api.fromJson(x)));
              datas.forEach((element) {
                String curr = (element.price.replaceAll(RegExp(','), ''));
                curr = (curr.replaceAll(RegExp("[\$,]"), ''));
                sum += double.parse(curr.replaceAll(RegExp('\$'), ''));
                if (element.isActive) {
                  isActive += 1;
                }
              });
              avg_price = sum / datas.length;
              return StaggeredGridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                children: <Widget>[
                  _buildTile(
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Total Purchases',
                                    style: TextStyle(color: Colors.blueAccent)),
                                Text('${datas.length} Purchases',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 34.0))
                              ],
                            ),
                            Material(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(24.0),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(Icons.timeline,
                                      color: Colors.white, size: 30.0),
                                )))
                          ]),
                    ),
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ShopItemsPage(datas,))),
                  ),


                  _buildTile(
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Material(
                              color: Colors.teal,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.settings_applications,
                                    color: Colors.white, size: 30.0),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 16.0)),
                            Text('General',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.0)),
                            Text(
                              'Images, Videos',
                              style: TextStyle(color: Colors.black45),
                            ),
                          ]),
                    ),
                    onTap: () {
                      showToast();
                    },
                  ),
                  _buildTile(
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Material(
                            color: Colors.amber,
                            shape: CircleBorder(),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.notifications,
                                  color: Colors.white, size: 30.0),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 16.0)),
                          Text('Alerts',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.0)),
                          Text('All ', style: TextStyle(color: Colors.black45)),
                        ],
                      ),
                    ),
                    onTap: () {
                      showToast();

                    },
                  ),
                  _buildTile(
                    Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Revenue',
                                    style: TextStyle(color: Colors.green)),
                                Text(
                                  '${sum.toStringAsFixed(3)}\$',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 34.0),
                                ),
                              ],
                            )),
                        Stack(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 1.70,
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(18),
                                    ),
                                    color: Colors.transparent),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 18.0, left: 12.0, top: 24, bottom: 12),
                                  child: LineChart(
                                    showAvg ? avgData() : mainData(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              height: 34,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    showAvg = !showAvg;
                                  });
                                },
                                child: Text(
                                  'avg',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color:
                                      showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    onTap: () {
                      showToast();

                    },
                  ),
                  _buildTile(
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Average Purchases Price',
                                    style: TextStyle(color: Colors.deepPurpleAccent)),
                                Text('${avg_price.toStringAsFixed(3)} \$',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 34.0))
                              ],
                            ),
                            Material(
                                color: Colors.deepPurpleAccent,
                                borderRadius: BorderRadius.circular(24.0),
                                child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(Icons.money,
                                          color: Colors.white, size: 30.0),
                                    )))
                          ]),
                    ),
                    onTap: () {
                      showToast();

                    },
                  ),
                  _buildTile(
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Active Items',
                                    style: TextStyle(color: Colors.redAccent)),
                                Text('${isActive}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 34.0))
                              ],
                            ),
                            Material(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(24.0),
                                child: Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(Icons.store,
                                      color: Colors.white, size: 30.0),
                                )))
                          ]),
                    ),
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ShopItemsPage(datas,))),
                  )
                ],
                staggeredTiles: [
                  StaggeredTile.extent(2, 110.0),
                  StaggeredTile.extent(1, 180.0),
                  StaggeredTile.extent(1, 180.0),
                  StaggeredTile.extent(2, 350.0),
                  StaggeredTile.extent(2, 110.0),
                  StaggeredTile.extent(2, 110.0),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                child: Text("No Connection"),
              );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ));
  }

  showToast(){
    Fluttertoast.showToast(
        msg: "Nothing implemented here yet, click 'total purchases'",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }
  Widget _buildTile(Widget child, {required Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
            gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
          interval: 1,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 32,
          interval: 1,
          margin: 12,
        ),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}
