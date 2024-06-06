import 'package:find_shop_test/core/font/font_style.dart';
import 'package:flutter/material.dart';

class CardLocationSearchWidget extends StatelessWidget {
  final String textCard;
  final String iconCard;
  final String textLocationCard;
  final String iconLocationCard;

  const CardLocationSearchWidget({
    super.key,
    required this.textCard,
    required this.iconCard,
    required this.textLocationCard,
    required this.iconLocationCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: Colors.black.withOpacity(0.12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textCard,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: FontAppStyle.fontLarge,
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      iconCard,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        textLocationCard,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Image.asset(
                      iconLocationCard,
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
