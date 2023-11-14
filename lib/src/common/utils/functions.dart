import 'package:collection/collection.dart';
import 'package:converter_app/src/features/converter/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/converter/data/repository.dart';
import '../../features/converter/widget/splash_page.dart';

bool equalList(List first, List second) =>
    const DeepCollectionEquality.unordered().equals(first, second);

Future<InitializeObjects> getAllData(
  ICurrencyRepository repository,
  SharedPreferences storage,
) async {
  final allCurrencies = await repository.getAllCurrencies();
  final DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
  final yesterdayCurrencies =
      await repository.getCurrencyFromDay(yesterday.toPath());
  return InitializeObjects(
    storage: storage,
    allCurrencies: allCurrencies,
    yesterdayCurrencies: yesterdayCurrencies,
  );
}
