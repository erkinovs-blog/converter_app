import 'package:shared_preferences/shared_preferences.dart';

import 'src/features/converter/utils/file_importer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await SharedPreferences.getInstance();
  runApp(App(storage: storage));
}
