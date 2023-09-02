import '../utils/file_importer.dart';

class DataStorage {
  DataStorage()
      : repository = CurrencyRepositoryImpl(APIService()),
        textEditingController1 = TextEditingController(),
        textEditingController2 = TextEditingController();

  ICurrencyRepository repository;
  TextEditingController textEditingController1;
  TextEditingController textEditingController2;

  List<Currency> allCurrencies = [];
  List<Currency> latestAllCurrencies = [];
  ValueNotifier<String> currentCity = ValueNotifier('USD');
  ValueNotifier<bool> isUzbekistan = ValueNotifier(true);
  ValueNotifier<String> result = ValueNotifier("");

  void getConvert(ValueNotifier<String> currentCity) {
    final a = allCurrencies.where((e) => e.ccy == currentCity.value).first.rate;
    if (isUzbekistan.value) {
      result.value =
          '1 UZS  = ${(1 / (double.tryParse(a!) as double)).toStringAsFixed(4)} ${currentCity.value}';
    } else {
      result.value = '1 ${currentCity.value} =  $a UZS';
    }
  }

  Future<void> getLatestCurrencies() async {
    DateTime date = DateTime.now();
    date = date.subtract(const Duration(days: 1));
    latestAllCurrencies = await repository.getCurrencyFromDay(
      '${date.year}-${date.month}-${(date.day)}',
    );
  }

  Future<void> setAllCurrencies() async {
    allCurrencies = await repository.getAllCurrencies();
    getConvert(currentCity);
  }
}
