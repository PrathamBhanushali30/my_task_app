import '../imports.dart';

///[TextView]  is common text class
class TextView extends StatelessWidget {
  const TextView(
      {Key? key,
        required this.text,
        this.fontSize = 15.0,
        this.fontWeight = FontWeight.w500,
        this.marginTop = 0,
        this.maxLine,
        this.textOverflow,
        this.lineheight,
        this.textAlign,
        this.textDecoration,
        this.laterSpacing,
        this.fontFamily,
        this.textColor,})
      : super(key: key);

  final TextDecoration? textDecoration;
  final double? fontSize;
  final String text;
  final String? fontFamily;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? marginTop;
  final int? maxLine;
  final TextOverflow? textOverflow;
  final double? lineheight;
  final TextAlign? textAlign;
  final double? laterSpacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop ?? 0),
      child: Text(
        text,
        textAlign: textAlign,
        overflow: textOverflow,
        maxLines: maxLine,
        style: TextStyle(
          letterSpacing: laterSpacing,
          decoration: textDecoration,
          height: lineheight,
          fontSize: fontSize ?? 16,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
          color: textColor,
        ),
      ),
    );
  }
}
