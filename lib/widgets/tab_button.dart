import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  const TabButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.onClose,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.15)
                : Colors.transparent,
            border: Border.all(
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[800],
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onClose,
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
