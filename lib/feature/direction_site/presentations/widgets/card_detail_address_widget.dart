import 'package:flutter/material.dart';

class CardDetailAddress extends StatelessWidget {
  const CardDetailAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.all(12.0),
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ที่อยู่'),
          SizedBox(height: 12),
          Divider(color: Color(0xFFE7E7E7)),
          SizedBox(height: 12),
          Text('62,64 ซอยองครักษ์ แขวงถนนนครไชยศรี เขตดุสิต กรุงเทพฯ 10300'),
        ],
      ),
    );
  }
}
