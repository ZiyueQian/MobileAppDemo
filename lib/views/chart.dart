import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChartState();
  }
}

class _ChartState extends State<Chart> {
  List<PieChartSectionData> _sections = List<PieChartSectionData>();

  @override
  void initState() {
    super.initState();
    PieChartSectionData _dispatching = PieChartSectionData(
        color: Colors.lightGreenAccent,
        value: 50,
        title: 'In delivery: 50',
        titleStyle: TextStyle(color: Colors.black),
        radius: 50);
    PieChartSectionData _delivered = PieChartSectionData(
        color: Colors.yellow,
        value: 100,
        title: 'Delivered: 100',
        titleStyle: TextStyle(color: Colors.black),
        radius: 50);
    _sections = [_dispatching, _delivered];
  }

  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: 1,
        child: FlChart(
            chart: PieChart(PieChartData(
          sections: _sections,
          borderData: FlBorderData(show: false),
          centerSpaceRadius: 40,
          sectionsSpace: 0,
        ))),
      ),
    );
  }
}
