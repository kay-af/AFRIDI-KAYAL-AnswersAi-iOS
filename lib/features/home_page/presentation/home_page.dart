import "package:flutter/cupertino.dart";
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
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: _buildTabBar(),
      tabBuilder: _buildTab,
    );
  }

  Widget _buildTab(BuildContext context, int index) {
    switch (index) {
      case 0:
        return const TodayPage();
      case 1:
        return const UnimplementedPage(pageName: "Games");
      case 2:
        return const UnimplementedPage(pageName: "Apps");
      case 3:
        return const UnimplementedPage(pageName: "Arcade");
      case 4:
        return const UnimplementedPage(pageName: "Search");
      default:
        return const UnimplementedPage(pageName: "Unknown");
    }
  }

  CupertinoTabBar _buildTabBar() {
    return CupertinoTabBar(
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
    );
  }
}
