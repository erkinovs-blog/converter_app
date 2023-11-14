import 'package:converter_app/src/features/converter/bloc/converter_bloc/converter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/file_importer.dart';

class StackDivider extends StatelessWidget {
  const StackDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Divider(
          color: Color(0xFFE7E7EE),
          thickness: 2,
        ),
        SizedBox(
          width: 44,
          height: 44,
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFF26278D),
            ),
            padding: EdgeInsets.zero,
            onPressed: context.read<ConverterBloc>().swap,
            icon: Padding(
              padding: EdgeInsets.all(8.0.h),
              child: const Image(
                image: AssetImage('assets/img/reverse.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
