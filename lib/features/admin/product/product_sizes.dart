import 'package:flutter/material.dart';

import '/core/_core.dart' show BuildContextExtensions;

class ProductSizes extends StatefulWidget {
  const ProductSizes({super.key});

  @override
  State<ProductSizes> createState() => _ProductSizesState();
}

class _ProductSizesState extends State<ProductSizes> {
  final List<String> _availableSizes = ["XS", "S", "M", "L", "XL", "XXL"];
  final List<String> _selectedSizes = [];

  void _submit() {
    Navigator.of(context).pop(_selectedSizes);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Select Sizes", style: context.textTheme.titleMedium),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children:
                _availableSizes.map((size) {
                  final isSelected = _selectedSizes.contains(size);
                  return ChoiceChip(
                    checkmarkColor:
                        isSelected ? context.theme.colorScheme.surface : null,
                    label: Text(
                      size,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color:
                            isSelected
                                ? context.theme.colorScheme.surface
                                : null,
                      ),
                    ),
                    selectedColor: context.theme.colorScheme.secondary,
                    labelStyle: context.textTheme.bodyMedium,
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedSizes.add(size);
                        } else {
                          _selectedSizes.remove(size);
                        }
                      });
                    },
                  );
                }).toList(),
          ),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: _submit, child: const Text('Done')),
        ],
      ),
    );
  }
}
