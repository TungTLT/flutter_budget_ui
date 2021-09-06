import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/constant.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:flutter_budget_ui/widgets/radial_painter.dart';

class CategoryDetailScreen extends StatelessWidget {
  final Category category;
  const CategoryDetailScreen({@required this.category});

  _buildItemCard(Expense item) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
      elevation: 0.8,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.name,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  item.cost.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildRadialChart(double totalExpense, double maxAmount) {
    return Container(
      width: double.infinity,
      height: 200.0,
      padding: EdgeInsets.all(10.0),
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
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: CustomPaint(
        foregroundPainter: RadialPainter(
            percent: totalExpense / category.maxAmount,
            bgColor: Colors.grey[200],
            lineColor: _getColor(totalExpense / category.maxAmount),
            width: 15.0),
        child: Center(
          child: Text('\$${totalExpense.toStringAsFixed(2)}/\$$maxAmount'),
        ),
      ),
    );
  }

  _getColor(double percent) {
    if (percent == 1)
      return Colors.red;
    else if (percent >= 0.5) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    double totalExpense = 0;
    category.expenses.forEach((element) {
      totalExpense += element.cost;
    });

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100.0,
            forceElevated: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                category.name,
                style: kAppBarTextStyle,
              ),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 22.0,
                )),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    size: 25.0,
                  ))
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0)
                  return _buildRadialChart(totalExpense, category.maxAmount);
                return _buildItemCard(category.expenses[index - 1]);
              },
              childCount: category.expenses.length + 1,
            ),
          ),
        ],
      ),
    );
  }
}
