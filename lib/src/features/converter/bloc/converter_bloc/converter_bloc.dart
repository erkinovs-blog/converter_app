import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:converter_app/src/common/utils/functions.dart';
import 'package:converter_app/src/features/converter/utils/extensions.dart';
import 'package:converter_app/src/features/converter/utils/file_importer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'converter_event.dart';
part 'converter_state.dart';

class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  static const firstKey = "first";
  static const secondKey = "second";

  final SharedPreferences _storage;
  final ICurrencyRepository _repository;

  ConverterBloc({
    required SharedPreferences storage,
    required ICurrencyRepository repository,
  })  : _storage = storage,
        _repository = repository,
        super(ConverterLoading()) {
    on<ConverterEvent>(
      (event, emit) => switch (event) {
        ConverterChangeValue changeValue => _changeCurrency(changeValue, emit),
        ConverterRefresh refresh => _refresh(refresh, emit),
        ConverterSwapValue swap => _swap(swap, emit),
        ConverterLoad loading => _loading(loading, emit),
        ConverterEvent _ => null,
      },
    );
  }

  void _changeCurrency(
    ConverterChangeValue event,
    Emitter<ConverterState> emit,
  ) async {
    final newModel =
        state.allCurrencies!.firstWhere((e) => e.ccy == event.newValue!);
    await _storage.setString(
        event.isFirst! ? firstKey : secondKey, event.newValue!);
    emit(state.copyWith(
      first: event.isFirst! ? newModel.ccy! : null,
      second: !event.isFirst! ? newModel.ccy! : null,
      currencyModel: newModel,
    ));
  }

  void _loading(ConverterLoad load, Emitter<ConverterState> emit) =>
      emit(ConverterLoading());

  void _refresh(ConverterRefresh event, Emitter<ConverterState> emit) async {
    if (event.isGlobal) emit(ConverterLoading());
    try {
      final data = await getAllData(_repository, _storage);
      emit(ConverterSuccess(
        first: data.getFirst(),
        second: data.getSecond(),
        currencyModel: data.getCurrency(),
        allCurrencies: data.allCurrencies,
        yesterdayCurrencies: data.yesterdayCurrencies,
      ));
    } on ClientException catch (e) {
      emit(ConverterError(e.message));
    } on SocketException catch (e) {
      emit(ConverterError(e.message));
    } catch (e) {
      emit(ConverterError(e));
    }
  }

  void _swap(ConverterSwapValue swap, Emitter<ConverterState> emit) async {
    await _storage.setString(firstKey, state.second!);
    await _storage.setString(secondKey, state.first!);
    emit(state.copyWith(
      first: state.second,
      second: state.first,
    ));
  }

  /// User Methods
  void changeCurrency({
    required bool isFirst,
    required newValue,
  }) =>
      add(ConverterChangeValue(isFirst: isFirst, newValue: newValue));

  void swap() => add(ConverterSwapValue());

  void refresh({bool? isGlobal}) => add(ConverterRefresh(isGlobal: isGlobal));
}
