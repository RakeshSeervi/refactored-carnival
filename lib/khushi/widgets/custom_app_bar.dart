import 'package:bloc_counter/khushi/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;

  CustomAppBar({
    Key? key,
    this.leading,
    this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Material(
      elevation: 1.0,
      child: SizedBox(
        height: SizeConfig.safeBlockVertical * 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  if (leading != null) leading!,
                  if (title != null)
                    Padding(
                      padding: EdgeInsets.only(
                        left: 12.0,
                      ),
                      child: title!,
                    ),
                ],
              ),
              Row(
                children: actions ?? [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
