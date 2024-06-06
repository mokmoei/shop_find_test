import 'package:find_shop_test/core/utils/date_time_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('convertTimeStringToDateTime should be convert', () {
    final text = AppDateTimeUtil.convertTimeStringToDateTime('12:22:12');
    expect(text, DateTime(6, 6, 6, 12, 22, 12));
  });

  test('dateToTimeString should be convert date correct format', () {
    final dateText = AppDateTimeUtil.dateToTimeString(
      DateTime(2020, 1, 1, 12, 32, 11),
    );
    expect(dateText, '12:32');
  });

  group('compareTimeInRange', () {
    test('compareTimeInRange should in range', () {
      final start = DateTime(6, 6, 6, 08, 00);
      final end = DateTime(6, 6, 6, 16, 00);
      final date = DateTime(6, 6, 6, 13, 30);
      final result = AppDateTimeUtil.compareTimeInRange(date, start, end);
      expect(result, true);
    });

    test('compareTimeInRange should not in range', () {
      final start = DateTime(6, 6, 6, 08, 00);
      final end = DateTime(6, 6, 6, 16, 00);
      final date = DateTime(6, 6, 6, 20, 30);
      final result = AppDateTimeUtil.compareTimeInRange(date, start, end);
      expect(result, false);
    });
  });
}
