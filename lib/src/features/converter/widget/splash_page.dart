import 'package:converter_app/src/features/converter/bloc/converter_bloc/converter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/file_importer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ConverterBloc, ConverterState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        builder: (context, state) {
          if (state is ConverterSuccess) {
            return const HomePage();
          } else if (state is ConverterLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: ElevatedButton.icon(
                label: Text((state as ConverterError).error.toString()),
                onPressed: () =>
                    context.read<ConverterBloc>().refresh(isGlobal: true),
                icon: const Icon(Icons.refresh),
              ),
            );
          }
        },
      ),
    );
  }
}

class InitializeObjects {
  final SharedPreferences storage;
  final List<Currency> allCurrencies;
  final List<Currency> yesterdayCurrencies;

  const InitializeObjects({
    required this.storage,
    required this.allCurrencies,
    required this.yesterdayCurrencies,
  });

  String getFirst() => storage.getString("first") ?? "USD";

  String getSecond() => storage.getString("second") ?? "UZS";

  Currency getCurrency() {
    final first = getFirst();
    if (first != "UZS") {
      return allCurrencies.firstWhere((element) => element.ccy == first);
    } else {
      return allCurrencies.firstWhere((element) => element.ccy == getSecond());
    }
  }
}
