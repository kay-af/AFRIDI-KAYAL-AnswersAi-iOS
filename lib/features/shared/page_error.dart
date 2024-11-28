import "package:flutter/cupertino.dart";

class PageError extends StatelessWidget {
  const PageError({super.key});

  static PageError builder(Object error, StackTrace stackTrace) {
    return const PageError();
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text("Error"),
      ),
    );
  }
}
