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
    DataStorage dataStorage = Provider.read(context).dataStorage;
    return SizedBox(
      width: 328.w,
      height: 250.h,
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: ListView.separated(
            itemCount: dataStorage.allCurrencies.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final Currency item = dataStorage.allCurrencies[index];
              final Currency lastDay = dataStorage.latestAllCurrencies[index];
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
      ),
    );
  }
}
