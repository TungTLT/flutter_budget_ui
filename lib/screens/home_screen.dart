import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/constant.dart';
import 'package:flutter_budget_ui/data/data.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/screens/category_detail_screen.dart';
import 'package:flutter_budget_ui/widgets/bar_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  _buildCategoryCard(BuildContext context, Category cate) {
    double totalExpense = 0;
    cate.expenses.forEach((element) {
      totalExpense += element.cost;
    });

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CategoryDetailScreen(
                    category: cate,
                  ))),
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cate.name,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '\$${totalExpense.toStringAsFixed(2)}/\$${cate.maxAmount.toStringAsFixed(2)}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: LinearProgressIndicator(
                  minHeight: 20.0,
                  value: totalExpense / cate.maxAmount,
                  color: _getColor(totalExpense / cate.maxAmount),
                  backgroundColor: Colors.grey[300],
                ),
              ),
            ],
          ),
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

  _buildChart() {
    return BarChart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            floating: true,
            expandedHeight: 100.0,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                size: 30.0,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Simple Budget',
                style: kAppBarTextStyle,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  size: 30.0,
                ),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) return _buildChart();
                return _buildCategoryCard(context, categories[index - 1]);
              },
              childCount: categories.length + 1,
            ),
          ),
        ],
      ),
    );
  }
}


// ListView.builder(
//           shrinkWrap: true,
//           itemCount: categories.length + 1,
//           itemBuilder: (context, index) {
//             if (index == 0) return _buildChart();
//             return _buildCategoryCard(context, categories[index - 1]);
//           })


