part of 'converter_bloc.dart';

@immutable
abstract class ConverterEvent {
  final bool? isFirst;
  final String? newValue;

  const ConverterEvent({
    this.isFirst,
    this.newValue,
  });
}

class ConverterLoad extends ConverterEvent {}

class ConverterChangeValue extends ConverterEvent {
  const ConverterChangeValue({required super.isFirst, required super.newValue});
}

class ConverterRefresh extends ConverterEvent {
  final bool isGlobal;

  const ConverterRefresh({bool? isGlobal}) : isGlobal = isGlobal ?? false;
}

class ConverterSwapValue extends ConverterEvent {}
