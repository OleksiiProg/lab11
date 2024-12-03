import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerConfig with ChangeNotifier {
  double _width = 50.0;
  double _height = 50.0;
  double _radius = 30.0;

  double get width => _width;
  double get height => _height;
  double get radius => _radius;

  void updateWidth(double value) {
    _width = value;
    notifyListeners();
  }

  void updateHeight(double value) {
    _height = value;
    notifyListeners();
  }

  void updateRadius(double value) {
    _radius = value;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ContainerConfig(),
      child: MaterialApp(home: HomePage()),
    ),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Лаб11")),
      body: Column(
        children: [

          Consumer<ContainerConfig>(
            builder: (context, config, child) => Column(
              children: [
                SliderRow(
                  label: "Width",
                  value: config.width,
                  onChanged: config.updateWidth,
                  min: 50,
                  max: 150,
                ),
                SliderRow(
                  label: "Height",
                  value: config.height,
                  onChanged: config.updateHeight,
                  min: 50,
                  max: 150,
                ),
                SliderRow(
                  label: "Radius",
                  value: config.radius,
                  onChanged: config.updateRadius,
                  min: 30,
                  max: 100,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Consumer<ContainerConfig>(
            builder: (context, config, child) => Container(
              width: config.width,
              height: config.height,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(config.radius),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SliderRow extends StatelessWidget {
  final String label;
  final double value;
  final void Function(double) onChanged;
  final double min;
  final double max;

  SliderRow({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label: ${value.toStringAsFixed(2)}"),
        Slider(
          value: value,
          onChanged: onChanged,
          min: min,
          max: max,
        ),
      ],
    );
  }
}
