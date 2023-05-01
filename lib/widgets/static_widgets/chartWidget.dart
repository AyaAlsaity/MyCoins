import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';

class ExpenseGraphDesign extends StatefulWidget {
  const ExpenseGraphDesign({Key? key}) : super(key: key);

  @override
  State<ExpenseGraphDesign> createState() => _ExpenseGraphDesignState();
}

class _ExpenseGraphDesignState extends State<ExpenseGraphDesign> {
  @override
  Widget build(BuildContext context) {
    final themeListener =
        Provider.of<DarkThemeProvider>(context, listen: true);
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 10,
        minY: 0,
        maxY: 10,
        backgroundColor: themeListener.isDark
              ? darkBackroundContinarColor
              : secondeyTextColor,
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 4),
              const FlSpot(1, 6),
              const FlSpot(2, 8),
              const FlSpot(3, 6.2),
              const FlSpot(4, 6),
              const FlSpot(5, 8),
              const FlSpot(6, 9),
              const FlSpot(7, 7),
              const FlSpot(8, 6),
              const FlSpot(9, 7.8),
              const FlSpot(10, 8),
            ],
            // isCurved: true,
            gradient: const LinearGradient(
              colors: [
                mainColor,
                mainColor,
              ],
            ),
            barWidth: 3,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                mainColor.withOpacity(0.2),
                mainColor.withOpacity(0.2),
                ],
              ),
            ),
            dotData: FlDotData(show: false),
          ),
        ],
        borderData:FlBorderData(show: false),
     
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 12,
                getTitlesWidget: (value, meta) {
                  String text = '';
                  switch (value.toInt()) {
                    case 1:
                      text = "1";
                      break;
                    case 2:
                      text = "2";
                      break;
                    case 3:
                      text = "3";
                      break;
                    case 4:
                      text = "4";
                      break;
                    case 5:
                      text = "5";
                      break;
                    case 6:
                      text = "6";
                      break;
                    case 7:
                      text = "7";
                      break;
                    case 8:
                      text = "8";
                      break;
                    case 9:
                      text = "9";
                      break;
                   
                    default:
                      return Container();
                  }
                  return Text(
                    text,
                    style:  TextStyle(
                      color: themeListener.isDark ? darktitleColor : mainTextColor,
                      fontSize: 10,
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}