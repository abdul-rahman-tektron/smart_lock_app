
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/screens/common/bottom_screen/bottom_notifier.dart';
import 'package:smart_lock_app/utils/widgets/custom_app_bar.dart';
import 'package:smart_lock_app/utils/widgets/custom_bottom_bar.dart';
import 'package:smart_lock_app/utils/widgets/custom_drawer.dart';

class BottomScreen extends StatelessWidget {
  final int? currentIndex;
  const BottomScreen({super.key, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomScreenNotifier(currentIndex),
      child: Consumer<BottomScreenNotifier>(
        builder: (context, bottomBarNotifier, child) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              bottomBarNotifier.changeTab(0);
            },
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.background,
                appBar: CustomAppBar(showDrawer: true,),
                drawer: CustomDrawer(),
                body: bottomBarNotifier.currentScreen,
                bottomNavigationBar: CustomBottomNavBar(
                  currentIndex: bottomBarNotifier.currentIndex,
                  onTap: (index) => bottomBarNotifier.changeTab(index),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

