import 'package:flutter/material.dart';

class HomeStatusScreen extends StatelessWidget {
  const HomeStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFFDFDF6),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      title: const Text(
        '금연 현황 상세보기',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3F5C2B),
        ),
      ),

      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('금연 유지 일수: 15일'),
          SizedBox(height: 12),
          Text('참은 담배: 300개비'),
          SizedBox(height: 12),
          Text('절약한 금액: 120,000원'),
        ],
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('닫기'),
        ),
      ],
    );
  }
}