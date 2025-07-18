import 'package:flutter/material.dart';

import 'frosted_glass_container.dart';

class InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData iconUsed;
  // not named parameters
  const InfoTile(
      this.iconUsed,
      this.label,
      this.value, {
        super.key,
      }
      );

  @override
  Widget build(BuildContext context) {
      return FrostedGlassContainer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Icon(
                    iconUsed,
                    size: constraints.maxWidth * 0.3, // Scales with width
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: constraints.maxWidth * 0.2, // Scales with width
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: constraints.maxWidth * 0.2, // Bigger than label
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }
}
