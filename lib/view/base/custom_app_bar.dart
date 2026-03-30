// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/util/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isBackButtonExist;
  final Function? onBackPressed;
  final List<Widget>? actions;
  final bool? centerTitle;
  const CustomAppBar({
    super.key,
    this.actions,
    this.title,
    this.isBackButtonExist,
    this.onBackPressed,
    this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    // var platform = Theme.of(context).platform;
    return AppBar(
      backgroundColor: Get.isDarkMode
          ? Theme.of(context).cardColor
          : Theme.of(context).primaryColor,
      title: title != null
          ? Text(
              title!.tr,
              textAlign: TextAlign.center,
              style: robotoRegular.copyWith(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: Get.isDarkMode
                    ? Theme.of(context).textTheme.bodyMedium!.color
                    : Theme.of(context).cardColor,
              ),
            )
          : const SizedBox(),
      centerTitle: centerTitle == null ? true : false,
      leading: isBackButtonExist!
          ? GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: Get.isDarkMode
                    ? Theme.of(context).textTheme.bodyMedium!.color
                    : Theme.of(context).cardColor,
              ),
              onTap: () => onBackPressed != null
                  ? onBackPressed!()
                  : Navigator.pop(context),
            )
          : const SizedBox(),
      actions: actions,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size(1170, GetPlatform.isDesktop ? 70 : 50);
}
