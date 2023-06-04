import 'package:flutter/material.dart';

class BarGraph extends StatelessWidget {
  final List<double> data;

  const BarGraph({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final val = data.length < 6
        ? data.reversed
        : data.sublist(data.length - 5, data.length).reversed;
    final maxData = val.isEmpty
        ? 0
        : data.reduce((value, element) => value > element ? value : element);
    const barWidth = 40.0;
    final scaleFactor = data.isEmpty
        ? 0.0
        : 150 /
            maxData; // Adjust the scale factor to fit the graph within the available height

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Movie Ratings History',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            val.isEmpty
                ? const Center(
                    child: Text('No Data Yet!'),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: val.map((value) {
                      final barHeight = value * scaleFactor;

                      return Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: barWidth,
                              height: barHeight,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(height: 8),
                            Text(value.toString()),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
