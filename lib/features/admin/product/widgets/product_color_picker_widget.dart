import 'package:flutter/material.dart';

import '/config/_config.dart' show ColorPickerComponent;

class ProductColorPickerWidget extends StatefulWidget {
  const ProductColorPickerWidget({super.key});

  @override
  State<ProductColorPickerWidget> createState() =>
      _ProductColorPickerWidgetState();
}

class _ProductColorPickerWidgetState extends State<ProductColorPickerWidget> {
  final _hexInputController = TextEditingController();
  Color _selectedColor = Colors.red;
  String _selectedHex = '';

  @override
  void dispose() {
    _hexInputController.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.of(context).pop(_selectedHex); // Return the selected color
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    _selectedHex = _hexInputController.text;
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
