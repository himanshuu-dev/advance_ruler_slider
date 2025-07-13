# 📏 Advance Ruler Slider
###### A highly customizable and reusable Flutter ruler/scale slider widget designed for precise value selection. This package offers a flexible and visually rich UI component that can be adapted to a wide range of applications, from health trackers to audio editors.

## ✨ Why Choose Advance Ruler Slider?
###### The advance_ruler_slider stands out by offering unparalleled control over both the aesthetics and functionality of a ruler-style input. Whether you need a simple weight selector or a complex audio timeline, its extensive customization options, smooth animations, and haptic feedback make it a robust choice for creating intuitive and engaging user experiences.

## 🚀 Features at a Glance
###### 🎨 Highly Customizable: Control every visual aspect, from tick colors and lengths to background gradients and border radii.

###### ↔️↕️ Horizontal & Vertical: Supports both orientations with consistent behavior.

###### 👆 Tactile Feedback: Optional haptic feedback on value changes enhances user interaction.

###### ✨ Smooth Animations: Programmatic jumps can be animated for a polished feel.

###### 🎯 Precise Control: Define step values for accurate increments and pixelsPerUnit for visual density.

###### 🔒 Read-Only Mode: Display values without allowing user interaction.

###### ✍️ Custom Labels: Format tick labels with custom text or units.

###### 💡 Custom Indicator: Use your own Widget as the central indicator for unique designs.

###### ➡️ Pointer/Arrow: Add a customizable triangular pointer to the indicator.

###### Highlight Active Range: Visually emphasize the currently visible portion of the ruler.

###### Boundary Labels: Always show min/max labels for clear range indication.

###### Flexible Scrolling: Apply custom ScrollPhysics for desired scroll behavior.

###### Snap-to-Tick: Automatically align to the nearest tick after scrolling.

###### Scrollable Range Clamping: Restrict user interaction to a sub-range of the full scale.

## 📦 Installation
##### Add this to your pubspec.yaml file:

```
dependencies:
  advance_ruler_slider: ^0.0.1 # Always use the latest version
```
##### Then, run flutter pub get in your project's root directory.

## 🖼️ Preview
![Horizontal Ruler Example](https://markdownlivepreview.com/image/sample.webp)
![Vertical Ruler Example](https://markdownlivepreview.com/image/sample.webp)

## 🚀 Basic Usage Example
##### Here's a simple horizontal weight ruler:
```
import 'package:flutter/material.dart';
import 'package:advance_ruler_slider/advance_ruler_slider.dart'; // Import your package

class BasicRulerDemo extends StatefulWidget {
  const BasicRulerDemo({super.key});

  @override
  State<BasicRulerDemo> createState() => _BasicRulerDemoState();
}

class _BasicRulerDemoState extends State<BasicRulerDemo> {
  double _currentWeight = 70.0; // Initial value
  final RulerScaleController _weightRulerController = RulerScaleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Ruler Slider Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Weight: ${_currentWeight.toStringAsFixed(1)} kg',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Container(
              height: 80, // Height for the horizontal ruler
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue.shade200, width: 2),
              ),
              child: RulerScale(
                controller: _weightRulerController,
                minValue: 0.0,
                maxValue: 150.0,
                initialValue: _currentWeight,
                majorTickInterval: 10.0,
                minorTickCount: 9, // 9 minor ticks means 10 segments (1.0 granularity)
                pixelsPerUnit: 25.0, // Adjust for desired spacing
                indicatorColor: Colors.blueAccent,
                indicatorWidth: 3.0,
                labelStyle: const TextStyle(color: Colors.black87, fontSize: 13),
                onValueChanged: (value) {
                  setState(() {
                    _currentWeight = value;
                  });
                },
                showIndicatorPointer: true,
                indicatorPointerLength: 12.0,
                indicatorPointerWidth: 12.0,
                indicatorPointerColor: Colors.blueAccent,
                hapticFeedbackEnabled: true,
                useScrollAnimation: true,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _weightRulerController.jumpToValue(95.0); // Programmatic jump
              },
              child: const Text('Jump to 95.0 kg'),
            ),
          ],
        ),
      ),
    );
  }
}

```

## 🛠️ Advanced Usage & Customization Examples
##### The RulerScale widget is incredibly flexible. Explore these examples to unlock its full potential:
##### Vertical Ruler with Custom Formatting, Gradients, and Physics
```
import 'package:flutter/material.dart';
import 'package:advance_ruler_slider/advance_ruler_slider.dart';

class AdvancedVerticalRuler extends StatefulWidget {
  const AdvancedVerticalRuler({super.key});

  @override
  State<AdvancedVerticalRuler> createState() => _AdvancedVerticalRulerState();
}

class _AdvancedVerticalRulerState extends State<AdvancedVerticalRuler> {
  double _currentHeight = 10.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vertical Ruler Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Height: ${_currentHeight.toStringAsFixed(1)}m',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              width: 100, // Width for the vertical ruler
              height: 300, // Height for the vertical ruler
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [Colors.green.shade100, Colors.green.shade300],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: RulerScale(
                direction: Axis.vertical,
                minValue: 0.0,
                maxValue: 20.0,
                majorTickInterval: 5.0,
                minorTickCount: 4, // 4 minor ticks = 5 segments between major ticks (0.5 granularity)
                pixelsPerUnit: 50.0, // More space for vertical ruler
                initialValue: _currentHeight,
                indicatorColor: Colors.green.shade700,
                indicatorWidth: 3.0,
                rulerExtent: 80.0, // Width of the ruler component itself
                labelStyle: const TextStyle(color: Colors.green, fontSize: 14),
                onValueChanged: (value) {
                  setState(() {
                    _currentHeight = value;
                  });
                },
                showIndicatorValue: true,
                showIndicatorPointer: true,
                indicatorPointerLength: 15.0,
                indicatorPointerWidth: 15.0,
                indicatorPointerColor: Colors.green.shade900,
                hapticFeedbackEnabled: true,
                labelFormatter: (value) {
                  if (value == 0) return 'Start';
                  if (value == 20) return 'End';
                  return '${value.toStringAsFixed(1)}m'; // Custom unit
                },
                activeRangeColor: Colors.green,
                activeRangeOpacity: 0.1,
                showBoundaryLabels: true,
                onScrollStart: () => print('Vertical ruler scroll started!'),
                onScrollEnd: () => print('Vertical ruler scroll ended!'),
                snapToTicksOnRelease: true, // Snap to nearest tick after scroll
                scrollPhysics: const BouncingScrollPhysics(), // iOS-like bounce
                indicatorGradient: LinearGradient(
                  colors: [Colors.lime.shade200, Colors.lime.shade700],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                minScrollValue: 5.0, // User can only scroll between 5.0 and 15.0
                maxScrollValue: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```


## Ruler with a Custom Indicator Widget
```

import 'package:flutter/material.dart';
import 'package:advance_ruler_slider/advance_ruler_slider.dart';

class CustomIndicatorRuler extends StatefulWidget {
  const CustomIndicatorRuler({super.key});

  @override
  State<CustomIndicatorRuler> createState() => _CustomIndicatorRulerState();
}

class _CustomIndicatorRulerState extends State<CustomIndicatorRuler> {
  double _currentValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Indicator Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Value: ${_currentValue.toStringAsFixed(0)}%',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Container(
              height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: RulerScale(
                direction: Axis.horizontal,
                minValue: 0.0,
                maxValue: 100.0,
                majorTickInterval: 25.0,
                minorTickCount: 4,
                pixelsPerUnit: 40.0,
                initialValue: _currentValue,
                rulerExtent: 70.0,
                labelStyle: const TextStyle(color: Colors.orange, fontSize: 14),
                onValueChanged: (value) {
                  setState(() {
                    _currentValue = value;
                  });
                },
                // Provide a custom indicator widget
                customIndicator: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade700,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.star, color: Colors.white, size: 24),
                ),
                showIndicatorValue: true, // Value will still appear below custom indicator
                labelOffset: 10.0, // Adjust label offset if needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

## Read-Only Ruler
```
import 'package:flutter/material.dart';
import 'package:advance_ruler_slider/advance_ruler_slider.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Read-Only Ruler Demo')),
      body: Center(
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
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: RulerScale(
                controller: _readOnlyRulerController,
                minValue: 0.0,
                maxValue: 200.0,
                initialValue: _displayValue,
                majorTickInterval: 20.0,
                minorTickCount: 9,
                pixelsPerUnit: 15.0,
                indicatorColor: Colors.purple,
                labelStyle: const TextStyle(color: Colors.black54, fontSize: 12),
                isReadOnly: true, // Make the ruler read-only
                showIndicatorValue: true,
                showIndicatorPointer: true,
                indicatorPointerColor: Colors.purple,
                hapticFeedbackEnabled: false, // No haptic feedback for read-only
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
          ],
        ),
      ),
    );
  }
}
```



## 📚 API Reference
##### Will add soon please wait.