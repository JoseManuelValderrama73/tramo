import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class AltitudeGraph extends StatelessWidget {
  final List<int> altitudes;
  const AltitudeGraph({super.key, required this.altitudes});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          minY: altitudes.reduce(min).toDouble(),
          maxY: altitudes.reduce(max).toDouble(),
          gridData: FlGridData(
            drawHorizontalLine: false,
            verticalInterval: altitudes.length < 10 ? 1 : altitudes.length / 10,
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) => Text(
                  value.toStringAsFixed(0),
                  style: TextStyle(
                    color: CupertinoColors.white.withValues(alpha: .6),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                interval: 10000,
              ),
            ),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: CupertinoColors.white.withValues(alpha: 0.2),
              width: 2,
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < altitudes.length; i++)
                  FlSpot(i.toDouble(), altitudes[i].toDouble()),
              ],
              isCurved: false,
              color: CupertinoColors.systemPurple,
              barWidth: 3,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: CupertinoColors.systemPurple.withOpacity(.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
