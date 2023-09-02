import '../utils/file_importer.dart';

class StackDivider extends StatelessWidget {
  const StackDivider({super.key});

  @override
  Widget build(BuildContext context) {
    DataStorage dataStorage = Provider.read(context).dataStorage;
    return Stack(
      alignment: Alignment.center,
      children: [
        const Divider(
          color: Color(0xFFE7E7EE),
          thickness: 2,
        ),
        SizedBox(
          width: 44,
          height: 44,
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFF26278D),
            ),
            padding: EdgeInsets.zero,
            onPressed: () {
              dataStorage.isUzbekistan.value = !dataStorage.isUzbekistan.value;
              dataStorage.getConvert(dataStorage.currentCity);
              dataStorage.textEditingController1.clear();
              dataStorage.textEditingController2.clear();
            },
            icon: Padding(
              padding: EdgeInsets.all(8.0.h),
              child: const Image(
                image: AssetImage('assets/img/reverse.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
