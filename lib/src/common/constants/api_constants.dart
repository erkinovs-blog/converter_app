abstract final class ApiConst {
  static const baseUrl = String.fromEnvironment(
    "base_url",
    defaultValue: "https://cbu.uz",
  );

  print(baseUrl);

  static const allCurrencyPath = "/oz/arkhiv-kursov-valyut/json";

  static String getUserFromId(String id) => "$allCurrencyPath/$id/";

  static String latestCurrencies(String date) => "$allCurrencyPath/all/$date/";
}
