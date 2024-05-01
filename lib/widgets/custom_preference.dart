import 'package:flutter/material.dart';
import 'package:profile_builder/models/preference_item.dart';

class CustomPreferences extends StatelessWidget {
  final List<PreferenceItem> preferences;
  final List<PreferenceItem> selectedPreferences;
  final Function(PreferenceItem)? togglePreference;
  final bool includeGestureDetector;

  const CustomPreferences({
    super.key,
    required this.preferences,
    this.togglePreference,
    this.selectedPreferences = const [],
    this.includeGestureDetector = false,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: preferences
          .map(
            (e) => includeGestureDetector
                ? GestureDetector(
                    onTap: () => togglePreference!(e),
                    child: _buildPreferenceWidget(e, context),
                  )
                : _buildPreferenceWidget(e, context),
          )
          .toList(),
    );
  }

  Widget _buildPreferenceWidget(
      PreferenceItem preference, BuildContext context) {
    EdgeInsets padding = EdgeInsets.symmetric(
      vertical: includeGestureDetector ? 8 : 4,
      horizontal: includeGestureDetector ? 12 : 8,
    );

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(20.0),
        color: selectedPreferences.contains(preference)
            ? Theme.of(context).colorScheme.primary
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            preference.iconData,
            size: 20,
            color: selectedPreferences.contains(preference)
                ? Colors.white
                : Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 4.0),
          Text(
            preference.name,
            style: TextStyle(
                fontSize: 14,
                color: selectedPreferences.contains(preference)
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
