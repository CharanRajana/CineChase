import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartCard extends StatelessWidget {
  final Map<String, double> data;

  const PieChartCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final max = data.isEmpty
        ? 0
        : data.values
            .reduce((value, element) => value > element ? value : element);
    final String peak = data.isEmpty
        ? ''
        : data.keys.firstWhere(
            (k) => data[k] == max,
          );
    final List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.yellow,
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Most Watched Genre : $peak',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            data.isEmpty
                ? const Center(
                    child: Text('No Data Yet!'),
                  )
                : PieChart(
                    dataMap: data,
                    colorList: colors,
                    chartRadius: MediaQuery.of(context).size.width / 2,
                    ringStrokeWidth: 24,
                    animationDuration: const Duration(seconds: 3),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValues: true,
                      showChartValuesOutside: true,
                      chartValueStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      showChartValuesInPercentage: true,
                      showChartValueBackground: false,
                    ),
                    legendOptions: const LegendOptions(
                      showLegends: true,
                      legendShape: BoxShape.rectangle,
                      legendTextStyle: TextStyle(fontSize: 15),
                      legendPosition: LegendPosition.bottom,
                      showLegendsInRow: true,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
