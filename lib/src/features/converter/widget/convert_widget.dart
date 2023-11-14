import 'package:converter_app/src/common/utils/functions.dart';
import 'package:converter_app/src/features/converter/bloc/converter_bloc/converter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/file_importer.dart';

class ConvertWidget extends StatefulWidget {
  final bool enabled;
  final TextEditingController controller;
  final String currency;

  const ConvertWidget({
    super.key,
    required this.enabled,
    required this.controller,
    required this.currency,
  });

  @override
  State<ConvertWidget> createState() => _ConvertWidgetState();
}

class _ConvertWidgetState extends State<ConvertWidget> {
  late TextEditingController controller;

  static const _border = OutlineInputBorder(
    borderSide: BorderSide.none,
  );

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFA1A1A1),
              radius: 25,
              child: CircleFlag((widget.currency == 'EUR')
                  ? 'european_union'
                  : widget.currency.substring(0, 2)),
            ),
            13.horizontalSpace,
            widget.currency == "UZS"
                ? const CustomText(
                    text: "UZS",
                    color: Color(0xFF26278D),
                    fontWeight: FontWeight.bold,
                  )
                : BlocBuilder<ConverterBloc, ConverterState>(
                    buildWhen: (previous, current) {
                      return !equalList(previous.allCurrencies ?? [],
                          current.allCurrencies ?? []);
                    },
                    builder: (context, state) {
                      if (state is ConverterSuccess) {
                        return DropdownButton(
                          underline: const SizedBox.shrink(),
                          value:
                              widget.currency == "UZS" ? null : widget.currency,
                          focusColor: Colors.transparent,
                          menuMaxHeight: 250,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          iconEnabledColor: const Color(0xFF26278D),
                          elevation: 4,
                          items: state.allCurrencies!
                              .map((e) => DropdownMenuItem(
                                    value: e.ccy!,
                                    alignment: Alignment.center,
                                    child: CustomText(
                                      text: e.ccy!,
                                      color: const Color(0xFF26278D),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              context.read<ConverterBloc>().changeCurrency(
                                    isFirst: widget.enabled,
                                    newValue: value,
                                  ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
          ],
        ),
        16.horizontalSpace,
        SizedBox(
          width: 130.w,
          height: 40.h,
          child: BlocConsumer<ConverterBloc, ConverterState>(
            listenWhen: (previous, current) =>
                (previous.first != current.first ||
                    previous.second != current.second) &&
                widget.enabled,
            listener: (context, state) =>
                widget.controller.text = state.getResult(controller.text),
            builder: (context, state) {
              return TextFormField(
                controller: widget.enabled ? controller : widget.controller,
                onChanged: (value) =>
                    widget.controller.text = state.getResult(value),
                textAlign: TextAlign.end,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter(RegExp(r"^\d+\.?\d*"),
                      allow: true),
                ],
                style: const TextStyle(
                  color: Color(0xFF26278D),
                  fontWeight: FontWeight.bold,
                ),
                enabled: widget.enabled,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  filled: true,
                  hintText: "0",
                  hintStyle: TextStyle(
                    color: Color(0xFF26278D),
                    fontWeight: FontWeight.bold,
                  ),
                  fillColor: Color(0xFFEDE8E8),
                  enabledBorder: _border,
                  disabledBorder: _border,
                  focusedBorder: _border,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
