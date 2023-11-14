import 'package:converter_app/src/common/utils/functions.dart';
import 'package:converter_app/src/features/converter/bloc/converter_bloc/converter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/file_importer.dart';

class CurrenciesList extends StatelessWidget {
  const CurrenciesList({super.key});

  String getDifference(Currency today, Currency lastDay) {
    final actualRate = double.tryParse(today.rate ?? '0') ?? 0;
    final lastDayRate = (double.tryParse(lastDay.rate ?? '0')) ?? 0;

    final diff = actualRate - lastDayRate;

    if (diff > 0) {
      return '+${diff.toStringAsFixed(2)}';
    } else if (diff < 0) {
      return diff.toStringAsFixed(2);
    } else {
      return '$diff';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: BlocBuilder<ConverterBloc, ConverterState>(
            buildWhen: (previous, current) =>
                !equalList(previous.allCurrencies!, current.allCurrencies!) ||
                !equalList(previous.yesterdayCurrencies!,
                    current.yesterdayCurrencies!),
            builder: (context, state) {
              return ScrollbarTheme(
                data: const ScrollbarThemeData(
                  mainAxisMargin: 20,
                ),
                child: Scrollbar(
                  radius: const Radius.circular(5),
                  child: ListView.separated(
                    itemCount: state.allCurrencies!.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final Currency item =
                          state.allCurrencies!.elementAt(index);
                      final Currency lastDay =
                          state.yesterdayCurrencies!.elementAt(index);
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: CurrencyListItem(
                          currency: item.ccyNmRu ?? '',
                          symbolCode: item.ccy ?? '',
                          change: getDifference(item, lastDay),
                          exchangeRate: item.rate ?? '',
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
