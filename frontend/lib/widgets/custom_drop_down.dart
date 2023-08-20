import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final TextStyle? textStyle;
  final ValueChanged<T?> onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    this.textStyle,
    required this.onChanged,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  T? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: _selectedItem,
      onChanged: (T? newValue) {
        setState(() {
          _selectedItem = newValue;
          widget.onChanged(newValue);
        });
      },
      underline: const SizedBox.shrink(), // Hide the default underline
      isExpanded: true,
      itemHeight: null,
      items: widget.items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            item.toString(),
            style: widget.textStyle,
          ),
        );
      }).toList(),
      hint: Text(
        'Select course',
        style: widget.textStyle ??
            const TextStyle(
              color: Colors.black,
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      icon: const Icon(Icons.arrow_drop_down),
    );
  }
}
