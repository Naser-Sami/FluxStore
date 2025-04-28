import 'package:flutter/material.dart';

import '/config/_config.dart' show ColorPickerComponent;

class ProductColors extends StatefulWidget {
  const ProductColors({super.key});

  @override
  State<ProductColors> createState() => _ProductColorsState();
}

class _ProductColorsState extends State<ProductColors> {
  final _hexInputController = TextEditingController();
  Color _selectedColor = Colors.red;

  @override
  void dispose() {
    _hexInputController.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.of(context).pop(_selectedColor); // Return the selected color
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding for better UX
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Important for bottom sheet
            children: [
              Wrap(
                children: [Text('Selected Color: ${_hexInputController.text}')],
              ),
              const SizedBox(height: 24),
              ColorPickerComponent(
                pickerColor: _selectedColor,
                onColorChanged: (Color color) {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                hexInputController: _hexInputController,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Add Color'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
