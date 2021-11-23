import 'package:flutter/material.dart';
import 'package:ta_mdp/models/stock.dart';

class StockList extends StatelessWidget {
  final List<Stock> stocks;

  StockList({required this.stocks});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey[400],
        );
      },
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final stock = stocks[index];

        return ListTile(
            contentPadding: EdgeInsets.all(10),
            title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${stock.symbol}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                  Text("${stock.company}",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 20,
                      ))
                ]),
            trailing: Column(children: <Widget>[
              Text(
                "\Rp${stock.price}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              )
            ]));
      },
    );
  }
}
