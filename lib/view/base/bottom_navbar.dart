// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zabi/util/images.dart';
import 'package:zabi/view/screens/category/category_screen.dart';
import 'package:zabi/view/screens/compass/compass_screen.dart';
import 'package:zabi/view/screens/home/home_screen.dart';
import 'package:zabi/view/screens/nearby_mosque/nearby_mosque_screen.dart';
import 'package:zabi/view/screens/quran/sura_list_screen.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  late List<Widget> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      const HomeScreen(),
      const CompassScreen(appBackButton: false),
      const SuraList(appBackButton: false),
      const NearbyMosque(appBackButton: false),
      CategoryScreen(appBackButton: false),
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;

    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: Container(
        height: (isIOS ? 70 : 70),
        decoration: BoxDecoration(
          color: Get.isDarkMode
              ? Theme.of(context).cardColor
              : Theme.of(context).primaryColor,
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Bottom Navigation Items
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Home
                  _buildNavItem(
                    index: 0,
                    icon: Images.Icon_Home,
                    label: "home".tr,
                  ),
                  // Compass
                  _buildNavItem(
                    index: 1,
                    icon: Images.Icon_Qibla,
                    label: "compass".tr,
                  ),

                  // Spacer for FAB
                  const SizedBox(width: 56),
                  // Nearby Mosque
                  _buildNavItem(
                    index: 3,
                    icon: Images.Icon_near_mosque,
                    label: "nearby".tr,
                  ),
                  // Category
                  _buildNavItem(
                    index: 4,
                    icon: Images.Icon_Category,
                    label: "category".tr,
                  ),
                ],
              ),
            ),
            // Floating Action Button (Quran)
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 28,
              bottom: 38,
              child: GestureDetector(
                onTap: () => _selectPage(2),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? Theme.of(context).cardColor.withOpacity(0.8)
                          : Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        Images.Nav_quran,
                        height: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String icon,
    required String label,
  }) {
    return GestureDetector(
      onTap: () => _selectPage(index),
      child: SizedBox(
        width: 75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 30,
              color: _selectedPageIndex == index
                  ? Get.isDarkMode
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor
                  : Get.isDarkMode
                      ? Theme.of(context).primaryColor.withOpacity(0.6)
                      : Theme.of(context).cardColor.withOpacity(0.6),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: _selectedPageIndex == index
                    ? Get.isDarkMode
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).cardColor
                    : Get.isDarkMode
                        ? Theme.of(context).primaryColor.withOpacity(0.6)
                        : Theme.of(context).cardColor.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
