import 'package:converter_app/src/features/converter/bloc/converter_bloc/converter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/file_importer.dart';

class ConverterCard extends StatefulWidget {
  const ConverterCard({super.key});

  @override
  State<ConverterCard> createState() => _ConverterCardState();
}

class _ConverterCardState extends State<ConverterCard> {
  late TextEditingController controller;

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
    return SizedBox(
      width: 320.w,
      height: 260.h,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        elevation: 4,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Сумма',
              ),
              BlocBuilder<ConverterBloc, ConverterState>(
                buildWhen: (previous, current) =>
                    previous.first != current.first,
                builder: (context, state) {
                  return ConvertWidget(
                    currency: state.first ?? "USD",
                    controller: controller,
                    enabled: true,
                  );
                },
              ),
              10.verticalSpace,
              5.verticalSpace,
              const StackDivider(),
              const CustomText(
                text: 'Конвертируемая сумма',
              ),
              BlocBuilder<ConverterBloc, ConverterState>(
                buildWhen: (previous, current) =>
                    previous.second != current.second,
                builder: (context, state) {
                  return ConvertWidget(
                    currency: state.second ?? "UZS",
                    controller: controller,
                    enabled: false,
                  );
                },
              ),
              10.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
