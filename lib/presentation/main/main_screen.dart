import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_app/domain/ext.dart';
import 'package:ticket_app/presentation/resources/asset_images.dart';

import '../home/home_screen.dart';
import '../styles/app_colors.dart';
import '../tickets/tickets_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: ref.bottomBarIndex == 0
          ? AppBar(
              title: const Text('Home'),
              centerTitle: true,
            )
          : null,
      body: _tabViews[ref.bottomBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ref.bottomBarIndex,
        onTap: (index) => ref.setBottomBarIndex(index),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            activeIcon: Image.asset(AssetImages.homeActive),
            icon: Image.asset(AssetImages.homeInactive),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(AssetImages.searchActive),
            icon: Image.asset(AssetImages.searchInactive),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(AssetImages.ticketsActive),
            icon: Image.asset(
              AssetImages.ticketsInactive,
              color: AppColors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(AssetImages.userActive),
            icon: Image.asset(AssetImages.userInactive),
            label: '',
          ),
        ],
      ),
    );
  }
}

List<Widget> _tabViews = [
  const HomeScreen(),
  Container(color: Colors.red),
  const TicketsScreen(),
  Container(color: Colors.yellow),
];
