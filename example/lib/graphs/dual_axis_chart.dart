import 'package:cristalyse/cristalyse.dart';
import 'package:flutter/material.dart';

Widget buildDualAxisTab(ChartTheme currentTheme,
    List<Map<String, dynamic>> data, double sliderValue) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Dual Y-Axis Chart'),
        const SizedBox(height: 8),
        const Text(
          'Revenue (bars, left axis) vs Conversion Rate (line, right axis)',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 400,
          child: CristalyseChart()
              .data(data)
              .mapping(x: 'month', y: 'revenue') // Primary Y-axis (left)
              .mappingY2('conversion_rate') // Secondary Y-axis (right)
              .geomBar(
                  width: sliderValue.clamp(0.1, 1.0),
                  alpha: 0.6,
                  color: currentTheme.colorPalette[0],
                  yAxis: YAxis.primary) // Uses left Y-axis
              .geomLine(
                  strokeWidth: 3.0,
                  alpha: 1.0,
                  color: currentTheme.colorPalette.length > 1
                      ? currentTheme.colorPalette[1]
                      : Colors.orange,
                  yAxis: YAxis.secondary) // Uses right Y-axis
              .geomPoint(
                  size: 6.0,
                  alpha: 1.0,
                  color: currentTheme.colorPalette.length > 1
                      ? currentTheme.colorPalette[1]
                      : Colors.orange,
                  yAxis: YAxis.secondary) // Uses right Y-axis
              .scaleXOrdinal()
              .scaleYContinuous(min: 0) // Left Y-axis (revenue)
              .scaleY2Continuous(
                  min: 0, max: 30) // Right Y-axis (percentage, adjusted range)
              .theme(currentTheme)
              .animate(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeOutCubic)
              .build(),
        ),
        const SizedBox(height: 16),
        const Text(
            '• Bars show revenue (left Y-axis in \$k)\n• Line shows conversion rate (right Y-axis in %)\n• Two independent scales for different data ranges\n• Perfect for correlating volume vs efficiency metrics'),
      ],
    ),
  );
}
