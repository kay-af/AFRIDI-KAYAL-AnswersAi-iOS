import "package:flutter/cupertino.dart";
import "package:flutter/services.dart";
import "package:store/features/routers/root_router.dart";

class App extends StatelessWidget {
  const App({super.key});

  String get title => "Store";

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: title,
      navigatorKey: rootRouter.navigatorKey,
      initialRoute: rootRouter.initialRoute,
      onGenerateRoute: rootRouter.onGenerateRoute,
      builder: _buildRoot,
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _buildRoot(BuildContext context, Widget? child) {
    // Sync the status bar brightness for light and dark modes
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarBrightness: MediaQuery.of(context).platformBrightness),
    );
    return child!;
  }
}
