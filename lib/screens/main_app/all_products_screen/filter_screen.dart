import 'package:e_commerce/constants.dart';
import 'package:e_commerce/size_config.dart';
import 'package:e_commerce/widgets/SectionTitle.dart';
import 'package:flutter/material.dart';

import '../../../widgets/DefaultButton.dart';

List<Color> colorFilter = const [
  Color(0xFFF6625E),
  Color(0xFF836DB8),
  Color(0xFFDECB9C),
  Color(0xFFFFFFFF),
  Color(0xFFb00b69),
  Color(0xFF162a40),
  Color(0xFFffbf00),
  Color(0xFF11037d),
];

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});
  static const routeName = '/FiltersScreen';

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late List<Color> filterColors;

  @override
  void didChangeDependencies() {
    filterColors = ModalRoute.of(context)?.settings.arguments as List<Color>;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Column(
        children: [
          SectionTitle(
            text: "Colors",
            button_text: "Clear selected",
            press: () {
              setState(() {
                filterColors.clear();
              });
            },
          ),
          Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Wrap(
              spacing: getProportionateScreenWidth(10),
              runSpacing: getProportionateScreenWidth(10),
              children: [
                ...colorFilter.map(
                  (color) => ColorChooseBlock(
                    color: color,
                    checked: filterColors.contains(color),
                    press: () {
                      if (!filterColors.contains(color)) {
                        setState(() {
                          filterColors.add(color);
                        });
                      } else {
                        setState(() {
                          filterColors.remove(color);
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: DefaultButton(
              text: "Close and apply",
              press: () {
                Navigator.of(context).pop(filterColors);
              },
            ),
          ),
          SizedBox(
            height: getProportionateScreenWidth(20),
          ),
        ],
      ),
    );
  }

  AppBar customAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          splashRadius: getProportionateScreenWidth(25),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      title: Text(
        'Filter products by...',
        style: TextStyle(
          color: Colors.black,
          fontSize: getProportionateScreenWidth(18),
        ),
      ),
      titleSpacing: 0,
    );
  }
}

class ColorChooseBlock extends StatefulWidget {
  const ColorChooseBlock({
    Key? key,
    required this.color,
    required this.checked,
    required this.press,
  }) : super(key: key);
  final Color color;
  final bool checked;
  final Function() press;

  @override
  State<ColorChooseBlock> createState() => _ColorChooseBlockState();
}

class _ColorChooseBlockState extends State<ColorChooseBlock> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: AnimatedContainer(
        duration: defaultDuration,
        width: getProportionateScreenWidth(47),
        height: getProportionateScreenWidth(47),
        padding: widget.checked
            ? EdgeInsets.all(
                getProportionateScreenWidth(2),
              )
            : null,
        decoration: BoxDecoration(
          color: widget.checked ? Colors.white : widget.color,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 1,
            ),
          ],
          border:
              widget.checked ? Border.all(width: 1, color: Colors.black) : null,
        ),
        child: widget.checked
            ? Container(
                decoration: BoxDecoration(
                  color: widget.color,
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: const Icon(Icons.check),
              )
            : null,
      ),
    );
  }
}
