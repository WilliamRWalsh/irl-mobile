import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 75, horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Coming Soon!',
              style: GoogleFonts.lobster(
                fontSize: 42,
                color: Colors.blue[400],
              ),
            ),
            Image(
              image: AssetImage('assets/sam-construction.png'),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeSeriesBar extends StatelessWidget {
  final List<Series<TimeSeriesSales, DateTime>> seriesList;
  final bool animate;

  TimeSeriesBar(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory TimeSeriesBar.withSampleData() {
    return new TimeSeriesBar(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TimeSeriesChart(
      seriesList,
      animate: animate,
      // Set the default renderer to a bar renderer.
      // This can also be one of the custom renderers of the time series chart.
      defaultRenderer: new BarRendererConfig<DateTime>(),
      // It is recommended that default interactions be turned off if using bar
      // renderer, because the line point highlighter is the default for time
      // series chart.
      defaultInteractions: false,
      // If default interactions were removed, optionally add select nearest
      // and the domain highlighter that are typical for bar
      behaviors: [new SelectNearest(), new DomainHighlighter()],
    );
  }

  /// Create one series with sample hard coded data.
  static List<Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2022, 1, 1), 1500),
      new TimeSeriesSales(new DateTime(2022, 1, 2), 1850),
      new TimeSeriesSales(new DateTime(2022, 1, 3), 1910),
      new TimeSeriesSales(new DateTime(2022, 1, 4), 1430),
      new TimeSeriesSales(new DateTime(2022, 1, 5), 1540),
      new TimeSeriesSales(new DateTime(2022, 1, 6), 1645),
      new TimeSeriesSales(new DateTime(2022, 1, 7), 1555),
      new TimeSeriesSales(new DateTime(2022, 1, 8), 1764),
    ];

    return [
      new Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
