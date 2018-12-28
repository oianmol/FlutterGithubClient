import 'package:flutter_test/flutter_test.dart';
import 'package:LoginUI/main.dart';

void main() {
  testWidgets("App should work", (WidgetTester tester) async {
    tester.pumpWidget(AppGithubClient());
  });
}
