import 'package:flutter/cupertino.dart';

import '../utils/file_importer.dart';

class CurrencyListItem extends StatelessWidget {
  final String currency;
  final String symbolCode;
  final String change;
  final String exchangeRate;

  const CurrencyListItem({
    super.key,
    required this.currency,
    required this.symbolCode,
    required this.change,
    required this.exchangeRate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: '1 $currency',
            fontWeight: FontWeight.bold,
          ),
          5.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFA1A1A1),
                radius: 25,
                child: CircleFlag((symbolCode == 'EUR')
                    ? 'european_union'
                    : symbolCode.substring(0, 2)),
              ),
              CustomText(
                text: symbolCode,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: change,
                        color: (double.tryParse(change) ?? 0) > 0
                            ? CupertinoColors.activeGreen
                            : ((double.tryParse(change) ?? 0) < 0)
                                ? Colors.red
                                : Colors.orange,
                      ),
                      Icon(
                        ((double.tryParse(change) ?? 0) > 0)
                            ? Icons.trending_up
                            : ((double.tryParse(change) ?? 0) < 0)
                                ? Icons.trending_down
                                : Icons.trending_neutral,
                        color: ((double.tryParse(change) ?? 0) > 0)
                            ? CupertinoColors.activeGreen
                            : ((double.tryParse(change) ?? 0) < 0)
                                ? Colors.red
                                : Colors.orange,
                      ),
                    ],
                  ),
                  CustomText(
                    text: exchangeRate,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
