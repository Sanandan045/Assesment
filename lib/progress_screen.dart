import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CheckCircularScreen extends StatefulWidget {
  const CheckCircularScreen({super.key});

  @override
  _CheckCircularScreenState createState() => _CheckCircularScreenState();
}

class _CheckCircularScreenState extends State<CheckCircularScreen> {
  double _progress = 50;
  Color _backgroundColor = const Color(0xffeeeeee);
  Color _foregroundColor = Colors.black;
  final TextEditingController _progressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _progressController.text = _progress.toString();
  }

  void _updateProgress(String value) {
    setState(() {
      _progress = double.tryParse(value) ?? _progress;
    });
  }

  void _updateBackgroundColor(Color newColor) {
    setState(() {
      _backgroundColor = newColor;
    });
  }

  void _updateForegroundColor(Color newColor) {
    setState(() {
      _foregroundColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Circular Progress'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: 150,
                    width: 100,
                    child: DashedCircularProgressBar.aspectRatio(
                      aspectRatio: 2, // width ÷ height
                      progress: _progress,
                      startAngle: 180,
                      sweepAngle: 360,
                      circleCenterAlignment: Alignment.bottomCenter,
                      foregroundColor: _foregroundColor,
                      backgroundColor: _backgroundColor,
                      foregroundStrokeWidth: 3,
                      backgroundStrokeWidth: 2,
                      backgroundGapSize: 2,
                      backgroundDashSize: 1,
                      seekColor: Colors.yellow,
                      seekSize: 22,
                      animation: true,
                    ),
                  ),
                ),
                SizedBox(height: 150),
                TextField(
                  controller: _progressController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Progress (0-100)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _updateProgress,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      Color? selectedColor = await showDialog<Color>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Select Your Unfilled Color'),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                pickerColor: _backgroundColor,
                                onColorChanged: (color) {
                                  Navigator.of(context).pop(color);
                                },
                              ),
                            ),
                          );
                        },
                      );
                      if (selectedColor != null) {
                        _updateBackgroundColor(selectedColor);
                      }
                    },
                    child: Text('Select your unfilled Color'),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      Color? selectedColor = await showDialog<Color>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Select your filled Color'),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                pickerColor: _foregroundColor,
                                onColorChanged: (color) {
                                  Navigator.of(context).pop(color);
                                },
                              ),
                            ),
                          );
                        },
                      );
                      if (selectedColor != null) {
                        _updateForegroundColor(selectedColor);
                      }
                    },
                    child: Text('Select Your filled Color'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }
}
