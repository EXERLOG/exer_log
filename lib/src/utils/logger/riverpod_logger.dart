import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'logger.dart';

class RiverpodLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    Log.info('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }

  @override
  void didDisposeProvider(ProviderBase<dynamic> provider, ProviderContainer containers) {
    Log.info('''
{
  "disposed provider": "${provider.name ?? provider.runtimeType}",
}''');
    super.didDisposeProvider(provider, containers);
  }
}
