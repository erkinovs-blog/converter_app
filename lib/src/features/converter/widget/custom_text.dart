import '../utils/file_importer.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double? fontSize;
  final Color color;

  const CustomText({
    required this.text,
    this.fontWeight = FontWeight.w400,
    this.fontSize,
    Color? color,
    super.key,
  }) : color = color ?? const Color(0xFFA1A1A1);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize ?? 15.sp,
        fontWeight: fontWeight,
      ),
    );
  }
}
