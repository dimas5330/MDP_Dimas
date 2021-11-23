import 'package:flutter/material.dart';
import 'package:ta_mdp/widgets/stock_list.dart';
import 'package:ta_mdp/models/stock.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Stocks",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold)),
                    Text("January 5",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SizedBox(
                            height: 50,
                            child: TextField(
                                decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              hintText: "Search",
                              prefix: Icon(Icons.search),
                              fillColor: Colors.grey[800],
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                            )))),
                    SizedBox(
                        height: MediaQuery.of(context).size.height - 310,
                        child: StockList(stocks: Stock.getAll()))
                  ]),
            ))
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: ('Home'),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.insert_chart_rounded,
                color: Colors.white,
              ),
              label: ('News'),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: ('Profile'),
              backgroundColor: Colors.black)
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
