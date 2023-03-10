import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class PlayerGraph extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  PlayerGraph({Key? key}) : super(key: key);

  @override
  PlayerGraphState createState() => PlayerGraphState();
}

class PlayerGraphState extends State<PlayerGraph> {
  List<_SalesData> data = [_SalesData('Jan', 35), _SalesData('Feb', 28), _SalesData('Mar', 34), _SalesData('Apr', 32), _SalesData('May', 40)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          //Initialize the spark charts widget
          child: SfSparkLineChart.custom(
            //Enable the trackball
            trackball: SparkChartTrackball(activationMode: SparkChartActivationMode.tap),
            //Enable marker
            marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.high),
            //Enable data label

            labelDisplayMode: SparkChartLabelDisplayMode.all,
            xValueMapper: (int index) => data[index].year,
            yValueMapper: (int index) => data[index].sales,
            dataCount: 5,
          ),
        ),
      )
    ]));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
