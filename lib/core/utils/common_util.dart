class CommonUtil {
  static String convertPhoneNumber(String input) {
    // Remove the word "flutter"
    String result = input.replaceFirst('flutter', '').trim();

    // Remove parentheses
    result = result.replaceAll(RegExp(r'[\(\)]'), '');

    // Remove spaces and hyphens
    result = result.replaceAll(' ', '').replaceAll('-', '');

    // Replace the word "ต่อ" with a comma
    result = result.replaceAll('ต่อ', ',');

    return result;
  }
}
