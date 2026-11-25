import 'package:flutter_map/flutter_map.dart';

/// Keeps one HTTP client alive for the whole app session.
///
/// `TileLayer` calls `dispose()` on its provider when a screen is popped.
/// The default [NetworkTileProvider] closes its HTTP client there, which
/// aborts any tile still downloading and logs a `ClientException` when the
/// user navigates back quickly. This provider simply avoids that close.
class _KeepAliveNetworkTileProvider extends NetworkTileProvider {
  @override
  void dispose() {}
}

class AppTileProviders {
  static final NetworkTileProvider openStreetMap =
      _KeepAliveNetworkTileProvider();
}
