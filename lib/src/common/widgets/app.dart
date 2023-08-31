import '../../features/converter/utils/file_importer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 703),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Converter App',
          theme: ThemeData(
            useMaterial3: true,
            // primarySwatch: Colors.blue,
            // textTheme: Typography.blackCupertino,
          ),
          home: const SplashPage(),
        );
      },
    );
  }
}
