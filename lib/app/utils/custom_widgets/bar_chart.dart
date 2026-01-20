
import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:fl_chart/fl_chart.dart';

class EarningsBarChart extends StatelessWidget {
  final List<double> values;
  final List<String> bottomValues;
  final String selectedChartType;

  const EarningsBarChart({super.key, required this.values, required this.bottomValues, required this.selectedChartType});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 220,
        width: selectedChartType.toLowerCase() == "weekly" ? Get.width *0.82 : 700,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barTouchData: BarTouchData(enabled: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 100,
                    getTitlesWidget: (value, meta) {
                      return Text('P${value.toInt()}', style: TextStyle(fontSize: 7));
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final days = bottomValues;
                      return Text(days[value.toInt()], style: TextStyle(fontSize: 12));
                    },
                  ),
                ),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              barGroups: values.asMap().entries.map((entry) {
                int index = entry.key;
                double value = entry.value;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: value,
                      color: AppTheme.primaryColor,
                      width: 16,
                      borderRadius: BorderRadius.circular(4),
                    )
                  ],
                );
              }).toList(),
              gridData: FlGridData(show: false),
            ),
          ),
        ),
      ),
    );
  }
}