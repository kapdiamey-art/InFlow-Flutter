import 'package:flutter/material.dart';
import 'package:inflow/core/app_theme.dart';

class InFlowLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final bool horizontal;
  
  const InFlowLogo({
    super.key, 
    this.size = 100,
    this.showText = false,
    this.horizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Widget logoIcon = Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.22),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(size * 0.25),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                _buildSubSquare(size),
                SizedBox(width: size * 0.08),
                _buildSubSquare(size),
              ],
            ),
          ),
          SizedBox(height: size * 0.08),
          Expanded(
            child: Row(
              children: [
                _buildSubSquare(size),
                SizedBox(width: size * 0.08),
                _buildSubSquare(size),
              ],
            ),
          ),
        ],
      ),
    );

    if (!showText) return logoIcon;

    if (horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          logoIcon,
          SizedBox(width: size * 0.3),
          Text(
            'InFlow',
            style: TextStyle(
              fontSize: size * 0.8,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : Colors.black,
              letterSpacing: -1.5,
            ),
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        logoIcon,
        const SizedBox(height: 16),
        Text(
          'InFlow',
          style: TextStyle(
            fontSize: size * 0.4,
            fontWeight: FontWeight.w900,
            color: isDark ? Colors.white : Colors.black,
            letterSpacing: -1,
          ),
        ),
      ],
    );
  }

  Widget _buildSubSquare(double parentSize) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(parentSize * 0.08),
        ),
      ),
    );
  }
}
