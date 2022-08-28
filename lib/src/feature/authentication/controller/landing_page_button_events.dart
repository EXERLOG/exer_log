import 'package:hooks_riverpod/hooks_riverpod.dart';

enum LandingButtonEvents {
  none,
  login,
  signUp,
}

final landingButtonEventsProvider =
    StateProvider.autoDispose<LandingButtonEvents>(
        (ref) => LandingButtonEvents.none);
