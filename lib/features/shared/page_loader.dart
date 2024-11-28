import "package:flutter/cupertino.dart";

class PageLoader extends StatelessWidget {
  const PageLoader({super.key});

  static PageLoader builder() {
    return const PageLoader();
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
