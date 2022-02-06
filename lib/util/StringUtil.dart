class StringUtil {

  static bool containsIgnoreCase(String baseStr, String subStr) {
    return baseStr.toLowerCase().contains(subStr.toLowerCase());
  }
}
