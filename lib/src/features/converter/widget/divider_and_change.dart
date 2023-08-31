import '../utils/file_importer.dart';

class StackDivider extends StatelessWidget {
  final TextEditingController textEditingController1;
  final TextEditingController textEditingController2;

  const StackDivider({
    super.key,
    required this.textEditingController1,
    required this.textEditingController2,
  });

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
        // GestureDetector(
        //   onTap: () {
        //     isUzbekistan.value = !isUzbekistan.value;
        //     getConvert(currentCity);
        //   },
        //   child: SizedBox(
        //     width: 44,
        //     height: 44,
        //     child: DecoratedBox(
        //       decoration: const BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: Color(0xFF26278D),
        //       ),
        //       child: Padding(
        //         padding: EdgeInsets.all(8.0.h),
        //         child: const Image(
        //           image: AssetImage('assets/img/reverse.png'),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
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
              textEditingController1.clear();
              textEditingController2.clear();
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
