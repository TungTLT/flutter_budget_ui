import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/data/data.dart';

class BarChart extends StatelessWidget {
  const BarChart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mostExpense = 0;
    weeklySpending.forEach((element) {
      if (element > mostExpense) mostExpense = element;
    });
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 5.0,
          )
        ],
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        children: [
          Text(
            'Weekly Spending',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back,
                    size: 28.0,
                  )),
              Text(
                'Sep 19, 2020 - Nov 20 2021',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 28.0,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(
                  label: 'Su',
                  amount: weeklySpending[0],
                  mostExpense: mostExpense),
              Bar(
                  label: 'Mo',
                  amount: weeklySpending[1],
                  mostExpense: mostExpense),
              Bar(
                  label: 'Tu',
                  amount: weeklySpending[2],
                  mostExpense: mostExpense),
              Bar(
                  label: 'We',
                  amount: weeklySpending[3],
                  mostExpense: mostExpense),
              Bar(
                  label: 'Th',
                  amount: weeklySpending[4],
                  mostExpense: mostExpense),
              Bar(
                  label: 'Fr',
                  amount: weeklySpending[5],
                  mostExpense: mostExpense),
              Bar(
                  label: 'Sa',
                  amount: weeklySpending[6],
                  mostExpense: mostExpense),
            ],
          ),
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amount;
  final double mostExpense;

  static const double _maxHeight = 200.0;

  const Bar({Key key, this.label, this.amount, this.mostExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '\$${amount.toStringAsFixed(2)}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
            height: amount / mostExpense * _maxHeight,
            width: 20.0,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          Text(label,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
