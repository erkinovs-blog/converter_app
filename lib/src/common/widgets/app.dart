import 'package:converter_app/src/features/converter/bloc/converter_bloc/converter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/converter/utils/file_importer.dart';

class App extends StatelessWidget {
  const App({super.key, required this.storage});

  final SharedPreferences storage;

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
          theme: ThemeData.light(useMaterial3: true),
          themeMode: ThemeMode.light,
          home: const SplashPage(),
          builder: (context, child) {
            return BlocProvider(
              create: (context) => ConverterBloc(
                storage: storage,
                repository: CurrencyRepositoryImpl(APIService()),
              )..add(const ConverterRefresh()),
              child: child,
            );
          },
        );
      },
    );
  }
}
