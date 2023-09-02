import 'package:intl/intl.dart';

import '../utils/file_importer.dart';

class ConvertWidget extends StatelessWidget {
  final bool enabled;

  ConvertWidget({super.key, required this.enabled})
      : formatter = NumberFormat.decimalPatternDigits(
          locale: 'en_us',
          decimalDigits: 2,
        );

  final NumberFormat formatter;
  final ValueNotifier<String> result = ValueNotifier("0");

  void exchange(String v, DataStorage dataStorage) {
    final current = double.tryParse(v) ?? 0;
    final a = dataStorage.allCurrencies
        .where((e) => e.ccy == dataStorage.currentCity.value)
        .first
        .rate;

    if (dataStorage.isUzbekistan.value) {
      result.value =
          formatter.format(current / (double.tryParse(a!) as double));
      dataStorage.textEditingController2.text = result.value;
    } else {
      result.value = formatter.format(
        (double.tryParse(a!) as double) * (double.tryParse(v) ?? 0),
      );

      dataStorage.textEditingController2.text = result.value;
    }
    if ((dataStorage.textEditingController1.text.isEmpty && enabled)) {
      dataStorage.textEditingController2.text = '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    DataStorage dataStorage = Provider.watch(context).dataStorage;
    return ValueListenableBuilder(
      valueListenable: dataStorage.isUzbekistan,
      builder: (context, value, child) {
        if (!enabled) {
          value = !value;
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ValueListenableBuilder(
              valueListenable: dataStorage.currentCity,
              builder: (context, currentCity, _) {
                return Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFFA1A1A1),
                      radius: 25,
                      child: CircleFlag(
                        value
                            ? 'UZ'
                            : dataStorage.currentCity.value == 'EUR'
                                ? 'european_union'
                                : dataStorage.currentCity.value.substring(0, 2),
                      ),
                    ),
                    13.horizontalSpace,
                    value
                        ? CustomText(
                            text: 'UZS',
                            color: const Color(0xFF26278D),
                            fontWeight: FontWeight.bold,
                          )
                        : DropdownButton(
                            underline: const SizedBox.shrink(),
                            value: currentCity,
                            focusColor: Colors.transparent,
                            menuMaxHeight: 250,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            iconEnabledColor: const Color(0xFF26278D),
                            elevation: 4,
                            items: List.generate(
                              dataStorage.allCurrencies.length,
                              (index) => DropdownMenuItem(
                                value: dataStorage.allCurrencies[index].ccy,
                                alignment: Alignment.center,
                                child: CustomText(
                                  text: dataStorage.allCurrencies[index].ccy ??
                                      '',
                                  color: const Color(0xFF26278D),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              dataStorage.currentCity.value = value!;
                              dataStorage.getConvert(dataStorage.currentCity);
                              dataStorage.textEditingController1.clear();
                              dataStorage.textEditingController2.clear();
                            },
                          ),
                  ],
                );
              },
            ),
            16.horizontalSpace,
            SizedBox(
              width: 130.w,
              height: 40.h,
              child: ValueListenableBuilder(
                valueListenable: result,
                builder: (context, res, _) {
                  return TextFormField(
                    controller: enabled
                        ? dataStorage.textEditingController1
                        : dataStorage.textEditingController2,
                    onChanged: (value) {
                      exchange(value, dataStorage);
                    },
                    textAlign: TextAlign.end,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp(r"^\d+\.?\d*"),
                          allow: true),
                    ],
                    style: const TextStyle(
                      color: Color(0xFF26278D),
                      fontWeight: FontWeight.bold,
                    ),
                    enabled: enabled,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      filled: true,
                      hintText: enabled ? '0' : res,
                      hintStyle: const TextStyle(
                        color: Color(0xFF26278D),
                        fontWeight: FontWeight.bold,
                      ),
                      fillColor: const Color(0xFFEDE8E8),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
