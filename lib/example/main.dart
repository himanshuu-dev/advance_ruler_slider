import 'package:advance_ruler_slider/advance_ruler_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AppDemo());
  }
}

class AppDemo extends StatefulWidget {
  const AppDemo({super.key});

  @override
  State<AppDemo> createState() => _AppDemoState();
}

class _AppDemoState extends State<AppDemo> {
  int _selectedIndex = 0;
  List rulers = [
    {'name': 'Horizontal ruler', 'view': HorizontalRulerDemo()},
    {'name': 'Vertical ruler', 'view': VerticalRuler()},
    {'name': 'Custom indicator ruler', 'view': CustomIndicatorRuler()},
    {'name': 'Read only ruler', 'view': ReadOnlyRulerDemo()},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(rulers[_selectedIndex]['name'])),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              for (var (i, item) in rulers.indexed)
                ListTile(
                  title: Text(item['name']),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedIndex = i;
                    });
                  },
                ),
            ],
          ),
        ),
      ),
      body: rulers[_selectedIndex]['view'],
    );
  }
}

class HorizontalRulerDemo extends StatefulWidget {
  const HorizontalRulerDemo({super.key});

  @override
  State<HorizontalRulerDemo> createState() => _HorizontalRulerDemoState();
}

class _HorizontalRulerDemoState extends State<HorizontalRulerDemo> {
  double _currentWeight = 70.0; // Initial value
  final RulerScaleController _weightRulerController = RulerScaleController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Selected Weight: ${_currentWeight.toStringAsFixed(1)} kg',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RulerScale(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200, width: 2),
              ),
              controller: _weightRulerController,
              rulerExtent: 90,
              step: 0.1,
              minValue: 10,
              maxValue: 200,
              majorTickInterval: 1,
              unitSpacing: 60, // Adjust for desired spacing
              initialValue: _currentWeight,
              hapticFeedbackEnabled: true,
              useScrollAnimation: true,
              showDefaultIndicator: false,
              selectedTickColor: Colors.blue,
              selectedTickWidth: 3,
              selectedTickLength: 20,
              indicatorWidth: 3.0,
              labelStyle: const TextStyle(color: Colors.black87, fontSize: 13),
              onValueChanged: (value) {
                setState(() {
                  _currentWeight = value;
                });
              },
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              _weightRulerController.jumpToValue(20); // Programmatic jump
            },
            child: const Text('Jump to 20KG'),
          ),
        ],
      ),
    );
  }
}

class VerticalRuler extends StatefulWidget {
  const VerticalRuler({super.key});

  @override
  State<VerticalRuler> createState() => _VerticalRulerState();
}

class _VerticalRulerState extends State<VerticalRuler> {
  double _currentHeight = 10.5;
  bool isScrolling = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Selected Height: ${_currentHeight.toStringAsFixed(1)}m',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Scrolling: $isScrolling',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 400,
            child: RulerScale(
              scrollPhysics: const BouncingScrollPhysics(), // iOS-like bounce
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.pink],
                ),
              ),
              step: 1,
              direction: Axis.vertical,
              minValue: 1,
              maxValue: 20.0,
              majorTickInterval: 5.0,
              majorTickColor: Colors.white60,
              minorTickColor: Colors.white54,
              unitSpacing: 20.0, // More space for vertical ruler
              initialValue: _currentHeight,
              indicatorColor: Colors.white70,
              indicatorWidth: 3.0,
              rulerExtent: 190, // Width of the ruler component itself
              showBoundaryLabels: true,
              selectedTickWidth: 4,
              labelStyle: const TextStyle(color: Colors.white, fontSize: 14),
              onValueChanged: (value) {
                setState(() {
                  _currentHeight = value;
                });
              },
              hapticFeedbackEnabled: true,
              labelFormatter: (value) {
                if (value == 1) return 'Start';
                if (value == 20) return 'End';
                return '${value.toStringAsFixed(1)}m'; // Custom unit
              },

              onScrollStart: () {
                WidgetsBinding.instance.addPostFrameCallback((callback) {
                  setState(() {
                    isScrolling = true;
                  });
                });
              },
              onScrollEnd: () {
                WidgetsBinding.instance.addPostFrameCallback((callback) {
                  setState(() {
                    isScrolling = false;
                  });
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomIndicatorRuler extends StatefulWidget {
  const CustomIndicatorRuler({super.key});

  @override
  State<CustomIndicatorRuler> createState() => _CustomIndicatorRulerState();
}

class _CustomIndicatorRulerState extends State<CustomIndicatorRuler> {
  double _currentValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Selected Value: ${_currentValue.toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          RulerScale(
            decoration: BoxDecoration(color: Colors.black),
            direction: Axis.horizontal,
            minValue: 0.0,
            maxValue: 100.0,
            majorTickInterval: 5.0,
            unitSpacing: 20.0,
            initialValue: _currentValue,
            minorTickColor: Colors.orange.shade300,
            majorTickColor: Colors.orange,
            selectedTickColor: Colors.white,
            rulerExtent: 150.0,
            labelStyle: const TextStyle(color: Colors.orange, fontSize: 14),
            onValueChanged: (value) {
              setState(() {
                _currentValue = value;
              });
            },
            // Provide a custom indicator widget
            customIndicator: Icon(
              Icons.arrow_upward_outlined,
              color: Colors.white,
            ),
            labelOffset: 10.0, // Adjust label offset if needed
          ),
        ],
      ),
    );
  }
}

class ReadOnlyRulerDemo extends StatefulWidget {
  const ReadOnlyRulerDemo({super.key});

  @override
  State<ReadOnlyRulerDemo> createState() => _ReadOnlyRulerDemoState();
}

class _ReadOnlyRulerDemoState extends State<ReadOnlyRulerDemo> {
  double _displayValue = 123.4;
  final RulerScaleController _readOnlyRulerController = RulerScaleController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Display Value: ${_displayValue.toStringAsFixed(1)}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Container(
            height: 80,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: RulerScale(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              controller: _readOnlyRulerController,
              minValue: 0.0,
              maxValue: 200.0,
              initialValue: _displayValue,
              majorTickInterval: 5.0,
              useScrollAnimation: true,
              unitSpacing: 15.0,
              selectedTickWidth: 4,
              indicatorColor: Colors.purple,
              labelStyle: const TextStyle(color: Colors.black54, fontSize: 12),
              isReadOnly: true, // Make the ruler read-only
              hapticFeedbackEnabled: false, // No haptic feedback for read-only
              onValueChanged: (value) {
                setState(() {
                  _displayValue = value;
                });
              },
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // You can still programmatically change the value
              setState(() {
                _displayValue = (_displayValue + 10).clamp(0.0, 200.0);
              });
              _readOnlyRulerController.jumpToValue(_displayValue);
            },
            child: const Text('Increment Value'),
          ),
          ElevatedButton(
            onPressed: () {
              // You can still programmatically change the value
              setState(() {
                _displayValue = (_displayValue - 10).clamp(0.0, 200.0);
              });
              _readOnlyRulerController.jumpToValue(_displayValue);
            },
            child: const Text('Decrement Value'),
          ),
          ElevatedButton(
            onPressed: () {
              _readOnlyRulerController.jumpToValue(90);
            },
            child: const Text('Jumpto 90'),
          ),
          ElevatedButton(
            onPressed: () {
              _readOnlyRulerController.jumpToValue(40);
            },
            child: const Text('Jumpto 40'),
          ),
        ],
      ),
    );
  }
}
