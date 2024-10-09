import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AssetPriceChart extends StatelessWidget {
  final Color lineColor;
  final List<FlSpot>? data;

  const AssetPriceChart({
    super.key,
    required this.lineColor,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      lineChartData,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get lineChartData => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData, // Customize grid
        borderData: borderData, // Customize border
        titlesData: const FlTitlesData(
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        lineBarsData: [
          lineChartBarData,
        ],
      );

  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) {
            return Colors.black.withOpacity(0.8);
          },
        ),
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(show: false);

  LineChartBarData get lineChartBarData => LineChartBarData(
        isCurved: true,
        color: lineColor,
        barWidth: 2,
        dotData: const FlDotData(show: false),
        spots: data?.where((spot) => spot.isValid()).toList() ??
            AssetPriceChart.generateSampleData(),
        belowBarData: BarAreaData(
          show: true,
          color: lineColor.withAlpha(50),
        ),
      );

  static List<FlSpot> generateSampleData() {
    final List<FlSpot> result = [];
    const numPoints = 35;
    const maxY = 6;

    double prev = 0;

    for (int i = 0; i < numPoints; i++) {
      final next = prev +
          Random().nextInt(3).toDouble() +
          Random().nextDouble() * maxY / 10;

      prev = next;

      if (!next.isFinite) {
        continue;
      }

      result.add(
        FlSpot(i.toDouble(), next),
      );
    }

    return result;
  }
}

extension FlSpotValidation on FlSpot {
  bool isValid() {
    return x.isFinite && y.isFinite && !x.isNaN && !y.isNaN;
  }
}
