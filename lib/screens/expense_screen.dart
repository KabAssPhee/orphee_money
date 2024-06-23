import 'package:bezier_chart_plus/bezier_chart_plus.dart';
import 'package:flutter/material.dart';
import 'package:orphee_money/widget/custom_selector.dart';
import 'package:orphee_money/widget/transaction_item_tile.dart';

import '../data/userInfo.dart';
import '../utils/constants.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  int _selectedTimeIndex = 0;
  int _selectedCatIndex = 0;
  final selectorLabels = ['Jours', 'Semaines', 'Mois'];
  List<String>? _transactionsCategories;
  List<Transaction> transactions = [];
  List<Transaction> filteredTransactions = [];

  _getActiveTimeFrame(int index) {
    switch (index) {
      case 0:
        return Center(
            child: Container(
          width: double.infinity,
          height: 300,
          child: Center(child: Text('Pas encore de données')),
        ));
      case 1:
        return ExpenseChartWidgetSemaines();
      case 2:
        return ExpenseChartWidget();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      transactions = [...transactions1, ...transactions2];
      getTransactionCategories();
    });
    super.initState();
  }

  getTransactionCategories() {
    setState(() {
      filteredTransactions.addAll(transactions);
      _transactionsCategories =
          transactions.map((tran) => tran.itemCategoryName).toSet().toList();
    });
  }

  updateTransactionCategory(String item) {
    setState(() {
      filteredTransactions =
          transactions.where((tran) => tran.itemCategoryName == item).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mes Transactions',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: fontDarker),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    _getActiveTimeFrame(_selectedTimeIndex),
                    Row(
                      children: [
                        ...selectorLabels.map((e) {
                          int index = selectorLabels.indexOf(e);
                          return CustomSelector(
                            height: 45,
                            onTap: () {
                              setState(() {
                                _selectedTimeIndex = index;
                              });
                            },
                            isSelected:
                                _selectedTimeIndex == selectorLabels.indexOf(e),
                            label: e,
                          );
                        }),
                        const SizedBox(width: 24),
                        Flexible(child: const Icon(Icons.calendar_month))
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dépenses',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: fontDarker,
                                  fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Revenus',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: fontDarker,
                                  fontWeight: FontWeight.w600),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    ...?_transactionsCategories?.map((tran) {
                      int index = _transactionsCategories!.indexOf(tran);
                      return CustomSelector(
                        height: 45,
                        onTap: () {
                          filteredTransactions.clear();
                          updateTransactionCategory(tran);
                          setState(() {
                            _selectedCatIndex = index;
                          });
                        },
                        isSelected: _selectedCatIndex ==
                            _transactionsCategories?.indexOf(tran),
                        label: tran,
                      );
                    })
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                ...filteredTransactions
                    .map((tran) => TransactionItemTile(transaction: tran))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExpenseChartWidget extends StatelessWidget {
  final fromDate = DateTime(2024, 3, 1);
  final toDate = DateTime(2024, 6, 20);

  final date1 = DateTime.now().subtract(Duration(days: 2));
  final date2 = DateTime.now().subtract(Duration(days: 3));

  final date3 = DateTime.now().subtract(Duration(days: 35));
  final date4 = DateTime.now().subtract(Duration(days: 36));

  final date5 = DateTime.now().subtract(Duration(days: 65));
  final date6 = DateTime.now().subtract(Duration(days: 64));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          bezierChartScale: BezierChartScale.monthly,
          fromDate: fromDate,
          toDate: toDate,
          selectedDate: toDate,
          series: [
            BezierLine(
              lineColor: Colors.red,
              label: "Dépenses",
              onMissingValue: (dateTime) {
                if (dateTime.month.isEven) {
                  return 10.0;
                }
                return 5.0;
              },
              data: [
                DataPoint<DateTime>(value: 10, xAxis: date1),
                DataPoint<DateTime>(value: 50, xAxis: date2),
                DataPoint<DateTime>(value: 20, xAxis: date3),
                DataPoint<DateTime>(value: 80, xAxis: date4),
                DataPoint<DateTime>(value: 14, xAxis: date5),
                DataPoint<DateTime>(value: 30, xAxis: date6),
              ],
            ),
          ],
          config: BezierChartConfig(
            verticalIndicatorStrokeWidth: 1.0,
            verticalIndicatorColor: Colors.blueGrey,
            showVerticalIndicator: true,
            verticalIndicatorFixedPosition: false,
            xAxisTextStyle: TextStyle(color: fontDarker, fontSize: 10),
            updatePositionOnTap: true,
            footerHeight: 35.0,
          ),
        ),
      ),
    );
  }
}

class ExpenseChartWidgetSemaines extends StatelessWidget {
  final fromDate = DateTime(2024, 05, 22);
  final toDate = DateTime.now();

  final date1 = DateTime.now().subtract(Duration(days: 2));
  final date2 = DateTime.now().subtract(Duration(days: 3));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          bezierChartScale: BezierChartScale.weekly,
          fromDate: fromDate,
          toDate: toDate,
          selectedDate: toDate,
          series: [
            BezierLine(
              lineColor: Colors.red,
              label: "Dépenses",
              onMissingValue: (dateTime) {
                if (dateTime.month.isEven) {
                  return 10.0;
                }
                return 5.0;
              },
              data: [
                DataPoint<DateTime>(value: 10, xAxis: date1),
                DataPoint<DateTime>(value: 50, xAxis: date2),
              ],
            ),
          ],
          config: BezierChartConfig(
            verticalIndicatorStrokeWidth: 1.0,
            verticalIndicatorColor: Colors.blueGrey,
            showVerticalIndicator: true,
            verticalIndicatorFixedPosition: false,
            xAxisTextStyle: TextStyle(color: fontDarker, fontSize: 10),
            updatePositionOnTap: true,
            footerHeight: 35.0,
          ),
        ),
      ),
    );
  }
}
