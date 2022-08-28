import 'package:exerlog/UI/global.dart';
import 'package:exerlog/src/feature/authentication/view/landing_page_button.dart';
import 'package:exerlog/src/feature/authentication/widgets/elevated_container.dart';
import 'package:exerlog/src/feature/authentication/widgets/login_form.dart';
import 'package:exerlog/src/feature/authentication/widgets/signup_form.dart';
import 'package:exerlog/src/widgets/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LandingScreen extends HookConsumerWidget {
  const LandingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);
    final tabIndex = useState(0);
    tabController.addListener(() => tabIndex.value = tabController.index);
    return ThemeProvider(
      builder: (context, theme) => Scaffold(
        backgroundColor: theme.colorTheme.backgroundColorVariation,
        body: ElevatedContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 40,
                child: TabBar(
                  controller: tabController,
                  tabs: [
                    /// TODO: Handle text style properly (applies everywhere)
                    Tab(child: Text("Login", style: loginOptionTextStyle)),
                    Tab(child: Text("Sign up", style: loginOptionTextStyle)),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    LoginForm(),
                    SignupForm(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              LandingPageButton(index: tabIndex.value),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
