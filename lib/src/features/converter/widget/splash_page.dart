import '../utils/file_importer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  DataStorage dataStorage = DataStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
          [dataStorage.setAllCurrencies(), dataStorage.getLatestCurrencies()]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Provider(
            dataStorage: dataStorage,
            child: const HomePage(),
          );
        }
      },
    );
  }
}
