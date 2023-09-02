import '../utils/file_importer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    super.dispose();
    Provider.read(context).dataStorage.textEditingController1.dispose();
    Provider.read(context).dataStorage.textEditingController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DataStorage dataStorage = Provider.watch(context).dataStorage;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.2, 1],
              colors: [Color(0xFFEAEAFE), Color(0xFFFFFFFF)],
            ),
          ),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 0.h),
                child: Column(
                  children: [
                    const TopText(),
                    10.verticalSpace,
                    const ConverterCard(),
                    10.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(text: 'Ориентировочный обменный курс'),
                        ValueListenableBuilder(
                            valueListenable: dataStorage.result,
                            builder: (context, result, _) {
                              return CustomText(
                                text: result,
                                fontWeight: FontWeight.bold,
                              );
                            }),
                      ],
                    ),
                    10.verticalSpace,
                    const CurrenciesList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
