import "package:flutter/cupertino.dart";

class UnimplementedPage extends StatelessWidget {
  final String pageName;

  const UnimplementedPage({
    required this.pageName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text("$pageName Page"),
      ),
    );
  }
}
