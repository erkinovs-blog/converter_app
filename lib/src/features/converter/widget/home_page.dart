import 'package:converter_app/src/features/converter/bloc/converter_bloc/converter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/file_importer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.2, 1],
              colors: [Color(0xFFEAEAFE), Color(0xFFFFFFFF)],
            ),
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<ConverterBloc>().refresh();
              await Future.delayed(const Duration(seconds: 2));
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 0.h),
                  child: Column(
                    children: [
                      const TopText(),
                      10.verticalSpace,
                      const ConverterCard(),
                      10.verticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CustomText(
                              text: 'Ориентировочный обменный курс'),
                          BlocBuilder<ConverterBloc, ConverterState>(
                            buildWhen: (previous, current) =>
                                previous.first != current.first ||
                                previous.second != current.second,
                            builder: (context, state) {
                              return CustomText(
                                text: state.getViewResult(),
                                fontWeight: FontWeight.bold,
                              );
                            },
                          ),
                        ],
                      ),
                      10.verticalSpace,
                      const CurrenciesList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
