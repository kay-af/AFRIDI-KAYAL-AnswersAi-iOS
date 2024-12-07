import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:store/features/home_page/today_page/presentation/today_page.dart";
import "package:store/features/home_page/unimplemented_page/presentation/unimplemented_page.dart";

class HomePage extends ConsumerStatefulWidget {
  static const route = "/";

  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier(0);

  @override
  void dispose() {
    _selectedIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        fit: StackFit.expand,
        children: [
          MediaQuery(
            data: MediaQuery.of(context).copyWith(
              padding: MediaQuery.of(context).padding + const EdgeInsets.only(bottom: 60),
            ),
            child: ValueListenableBuilder(
              valueListenable: _selectedIndexNotifier,
              builder: (context, index, child) => IndexedStack(
                index: index,
                children: const [
                  TodayPage(),
                  UnimplementedPage(pageName: "Games"),
                  UnimplementedPage(pageName: "Apps"),
                  UnimplementedPage(pageName: "Arcade"),
                  UnimplementedPage(pageName: "Unknown"),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildTabBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return AnimatedSlide(
      offset: Offset(0, ModalRoute.of(context)!.isCurrent ? 0 : 1),
      duration: Durations.medium1,
      curve: Curves.easeInOut,
      child: ValueListenableBuilder(
        valueListenable: _selectedIndexNotifier,
        builder: (context, index, child) => CupertinoTabBar(
          currentIndex: index,
          onTap: (index) => _selectedIndexNotifier.value = index,
          height: 60,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.today),
              label: "Today",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.rocket_fill),
              label: "Games",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square_stack_3d_up_fill),
              label: "Apps",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.game_controller_solid),
              label: "Arcade",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: "Search",
            ),
          ],
        ),
      ),
    );
  }
}
