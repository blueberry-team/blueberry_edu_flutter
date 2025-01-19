import 'package:flutter/material.dart';

class NonResponsiveCalendar extends StatelessWidget {
  const NonResponsiveCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
                onPressed: () {},
              ),
              Text(
                '2024년 1월',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: ['일', '월', '화', '수', '목', '금', '토'].map((day) => Expanded(
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            )).toList(),
          ),
          SizedBox(height: 8),
          ...List.generate(6, (weekIndex) =>
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: List.generate(7, (dayIndex) =>
                      Expanded(
                        child: Container(
                          height: 36,
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey[200]!,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${weekIndex * 7 + dayIndex + 1}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}