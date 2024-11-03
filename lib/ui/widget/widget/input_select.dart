/* import 'package:flutter/material.dart';

class InputSelect extends StatelessWidget {
  const InputSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<ColorLabel>(
      initialSelection: ColorLabel.green,
      controller: colorController,
      // requestFocusOnTap is enabled/disabled by platforms when it is null.
      // On mobile platforms, this is false by default. Setting this to true will
      // trigger focus request on the text field and virtual keyboard will appear
      // afterward. On desktop platforms however, this defaults to true.
      requestFocusOnTap: true,
      label: const Text('Color'),
      onSelected: (ColorLabel? color) {
        setState(() {
          selectedColor = color;
        });
      },
      dropdownMenuEntries: ColorLabel.values
          .map<DropdownMenuEntry<ColorLabel>>((ColorLabel color) {
        return DropdownMenuEntry<ColorLabel>(
          value: color,
          label: color.label,
          enabled: color.label != 'Grey',
          style: MenuItemButton.styleFrom(
            foregroundColor: color.color,
          ),
        );
      }).toList(),
    );
  }
}
 */