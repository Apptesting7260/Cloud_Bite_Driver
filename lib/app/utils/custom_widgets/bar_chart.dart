
import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:fl_chart/fl_chart.dart';

class EarningsBarChart extends StatelessWidget {
  final List<double> values;

  EarningsBarChart({required this.values});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 400,
                getTitlesWidget: (value, meta) {
                  return Text('\$${value.toInt()}', style: TextStyle(fontSize: 7));
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final days = ['12', '13', '14', '15', '16', '17', '18'];
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
    );
  }
}