import '../utils/file_importer.dart';

class Provider extends InheritedWidget {
  final DataStorage dataStorage;

  const Provider({
    super.key,
    required Widget child,
    required this.dataStorage,
  }) : super(child: child);

  static Provider read(BuildContext context) {
    return context.getElementForInheritedWidgetOfExactType<Provider>()!.widget
        as Provider;
  }

  static Provider watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!;
  }

  @override
  bool updateShouldNotify(Provider oldWidget) {
    return dataStorage != oldWidget.dataStorage;
  }
}
