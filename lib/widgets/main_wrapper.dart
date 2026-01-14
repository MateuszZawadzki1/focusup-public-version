import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_up/cubits/bottom_nav_cubit/bottom_nav_cubit_cubit.dart';
import 'package:focus_up/features/ambient_set/presentation/pages/set_screen.dart';
import 'package:focus_up/features/ambient_set/presentation/pages/set_view.dart';
import 'package:focus_up/features/ambient_set/presentation/pages/sets_view.dart';
import 'package:focus_up/l10n/l10n_helper.dart';
import 'package:focus_up/screens/home_view.dart';
import 'package:focus_up/style/color.dart';
import 'package:focus_up/widgets/scaffold_with_music_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import '../screens/screens.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() {
    return _MainWrapper();
  }
}

class _MainWrapper extends State<MainWrapper> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final List<Widget> topLevelScreens = const [
    HomeView(),
    SetsView(),
    FocusScreen(),
    StatsScreen(),
  ];

  void onPageChanged(int page) {
    BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithMusicBar(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 2, 2, 2),
        bottomNavigationBar: _mainWrapperBottomNavBar(context),
        floatingActionButton: _mainWrapperFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: _mainWrapperBody(),
      ),
    );
  }

  PageView _mainWrapperBody() {
    // Sprawdzic
    return PageView(
      onPageChanged: (int page) => onPageChanged(page),
      controller: pageController,
      children: topLevelScreens,
    );
  }

  // AppBar _mainWrapperAppBar() {
  //   return AppBar(
  //     backgroundColor: Colors.black,
  //     title: const Text('BottomNav'),
  //   );
  // }

  // Single Item in Bottom Navigation
  Widget _bottomAppBarItem(
    BuildContext context, {
    required defaultIcon,
    required page,
    required label,
    required filledIcon,
  }) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);

        pageController.animateToPage(
          page,
          duration: Duration(milliseconds: 10),
          curve: Curves.fastLinearToSlowEaseIn,
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Icon(
              context.watch<BottomNavCubit>().state == page
                  ? filledIcon
                  : defaultIcon,
              color:
                  context.watch<BottomNavCubit>().state == page
                      ? secondaryColor
                      : Colors.grey,
              size: 26,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.aBeeZee(
                color:
                    context.watch<BottomNavCubit>().state == page
                        ? secondaryColor
                        : Colors.grey,
                fontSize: 13,
                fontWeight:
                    context.watch<BottomNavCubit>().state == page
                        ? FontWeight.w600
                        : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BottomAppBar _mainWrapperBottomNavBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _bottomAppBarItem(
                  context,
                  defaultIcon: IconlyLight.home,
                  page: 0,
                  label: context.l10n.home,
                  filledIcon: IconlyBold.home,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: IconlyLight.paper,
                  page: 1,
                  label: context.l10n.sets,
                  filledIcon: IconlyBold.paper,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: IconlyLight.work,
                  page: 2,
                  label: context.l10n.focus,
                  filledIcon: IconlyBold.work,
                ),
                _bottomAppBarItem(
                  context,
                  defaultIcon: IconlyLight.chart,
                  page: 3,
                  label: context.l10n.stats,
                  filledIcon: IconlyBold.chart,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  FloatingActionButton _mainWrapperFab() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SetView()),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      backgroundColor: secondaryColor,
      child: const Icon(Icons.add, color: primaryColor),
    );
  }
}
