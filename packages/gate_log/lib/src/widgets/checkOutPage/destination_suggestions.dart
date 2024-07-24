import 'package:flutter/material.dart';
import 'package:onestop_kit/onestop_kit.dart';

class DestinationSuggestions extends StatelessWidget {
  final void Function(String) onChanged;
  final String selectedDestination;
  final List<String> destinationSuggestions;

  const DestinationSuggestions({
    super.key,
    required this.onChanged,
    required this.selectedDestination,
    required this.destinationSuggestions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Destination: ",
            style: OnestopFonts.w500
                .size(14)
                .setColor(OneStopColors.cardFontColor2),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              runAlignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              children: destinationSuggestions
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        onChanged(e);
                      },
                      child: buildDestinationChip(e, selectedDestination == e),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDestinationChip(String destination, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(360),
        color: selected ? OneStopColors.primaryColor : Colors.transparent,
        border: !selected
            ? Border.all(color: OneStopColors.primaryColor, width: 1)
            : null,
      ),
      child: Text(
        destination,
        style: selected
            ? OnestopFonts.w500.size(14)
            : OnestopFonts.w500.size(14).setColor(OneStopColors.primaryColor),
      ),
    );
  }
}
