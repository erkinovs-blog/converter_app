part of 'converter_bloc.dart';

@immutable
abstract class ConverterState {
  final List<Currency>? allCurrencies;
  final List<Currency>? yesterdayCurrencies;
  final String? first;
  final String? second;
  final Currency? currencyModel;

  const ConverterState({
    this.first,
    this.second,
    this.currencyModel,
    this.allCurrencies,
    this.yesterdayCurrencies,
  });

  String getResult(String result, [int digit = 5]) {
    if (result.isEmpty) return "0";
    NumberFormat formatter = NumberFormat.decimalPatternDigits(
      locale: 'en_us',
      decimalDigits: digit,
    );
    final rate = double.parse(currencyModel!.rate!);
    final value = double.parse(result);
    if (first != "UZS") {
      return formatter.format(rate * value).removeZero();
    } else {
      return formatter.format(value / rate).removeZero();
    }
  }

  ConverterSuccess copyWith({
    List<Currency>? allCurrencies,
    List<Currency>? yesterdayCurrencies,
    String? first,
    String? second,
    Currency? currencyModel,
  }) {
    return ConverterSuccess(
      first: first ?? this.first,
      second: second ?? this.second,
      currencyModel: currencyModel ?? this.currencyModel,
      allCurrencies: allCurrencies ?? this.allCurrencies,
      yesterdayCurrencies: yesterdayCurrencies ?? this.yesterdayCurrencies,
    );
  }

  String getViewResult() => "1 $first = ${getResult("1")} $second";
}

class ConverterLoading extends ConverterState {}

class ConverterError extends ConverterState {
  final Object error;

  const ConverterError(this.error);
}

class ConverterSuccess extends ConverterState {
  const ConverterSuccess({
    required super.first,
    required super.second,
    required super.currencyModel,
    required super.allCurrencies,
    required super.yesterdayCurrencies,
  });
}
