import '../utils/file_importer.dart';

class ConverterCard extends StatefulWidget {
  const ConverterCard({super.key});

  @override
  State<ConverterCard> createState() => _ConverterCardState();
}

class _ConverterCardState extends State<ConverterCard> {
  late TextEditingController textEditingController1;
  late TextEditingController textEditingController2;

  @override
  void initState() {
    super.initState();
    textEditingController1 = TextEditingController();
    textEditingController2 = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController1.dispose();
    textEditingController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DataStorage dataStorage = Provider.watch(context).dataStorage;
    return SizedBox(
      width: 320.w,
      height: 260.h,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        elevation: 4,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: ValueListenableBuilder(
            valueListenable: dataStorage.isUzbekistan,
            builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Сумма',
                  ),
                  ConvertWidget(
                    enabled: true,
                  ),
                  10.verticalSpace,
                  5.verticalSpace,
                  const StackDivider(),
                  CustomText(
                    text: 'Конвертируемая сумма',
                  ),
                  ConvertWidget(
                    enabled: false,
                  ),
                  10.verticalSpace,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
