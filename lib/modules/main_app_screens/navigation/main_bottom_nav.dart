import 'package:plateau_riders/modules/main_app_screens/screens/explore_screen/explore_screen.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/home_screen/home_screen.dart';

import 'package:plateau_riders/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plateau_riders/modules/app_colors/plateau_colors.dart';
import 'package:plateau_riders/modules/app_colors/responsiveness.dart';

class MainBottomNav extends StatefulWidget {
  const MainBottomNav({super.key});

  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav> {
  int _selectedIndex = 0;

  bool vendorHasServices = false;

  void onServiceAdded() {
    if (mounted) {
      setState(() {
        vendorHasServices = true;
      });
    }
  }

  late final List<Widget> widgetOptions;

  @override
  void initState() {
    super.initState();
    widgetOptions = <Widget>[
      // Pass the state down to the home screen.
      // const HomeScreen(),
      // const ExploreScreen(),
      // const MyVendorsScreen(),

      // const ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Rebuild the widgetOptions list if the state changes, so VendorHomeScreen gets the updated value.
    final updatedWidgetOptions = <Widget>[
      // const HomeScreen(),
      // const ExploreScreen(),
      // const MyVendorsScreen(),
      // const ProfileScreen(),
    ];

    return Scaffold(
      // backgroundColor: PlateauColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: updatedWidgetOptions, // Use the updated list
            ),
          ),
          _buildCustomNavBar(),
        ],
      ),
    );
  }

  Widget _buildCustomNavBar() {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: context.scaleSpacing(10),
            offset: Offset(0, context.scaleSpacing(-2)),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          _buildNavItem(
            index: 0,
            svgAsset: 'assets/svgs/home.svg',
            label: 'Home',
          ),
          _buildNavItem(
            index: 1,
            svgAsset: 'assets/svgs/search.svg',
            label: 'Explore',
          ),
          _buildNavItem(
            index: 2,
            svgAsset: 'assets/svgs/hugeicons_favourite.svg',
            label: 'My Vendors',
          ),
          _buildNavItem(
            index: 3,
            svgAsset: 'assets/svgs/hugeicons_user-circle.svg',
            label: 'Account',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String svgAsset,
    required String label,
  }) {
    final bool isActive = _selectedIndex == index;
    final activeDecoration = BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Theme.of(context).scaffoldBackgroundColor,
          Theme.of(context).scaffoldBackgroundColor,
          // PlateauColors.backgroundColor,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0.0, 0.9],
      ),
      border: Border(
        top: BorderSide(
          color: PlateauColors.primaryColor,
          width: context.scaleWidth(2.5),
        ),
      ),
    );

    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        behavior: HitTestBehavior.translucent,
        child: Container(
          decoration: isActive ? activeDecoration : null,
          padding: EdgeInsets.symmetric(vertical: context.scaleHeight(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                svgAsset,
                width: context.scaleImage(24),
                height: context.scaleImage(24),
                colorFilter: ColorFilter.mode(
                  isActive ? PlateauColors.primaryColor : PlateauColors.greyColor,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(height: context.scaleHeight(4)),
              Text(
                label,
                // style: AppTheme.navBar.copyWith(
                //   color:
                //       isActive ? PlateauColors.primaryColor : PlateauColors.greyColor,
                // ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
