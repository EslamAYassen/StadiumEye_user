import 'dart:async';

/// Broadcasts a one-shot signal whenever any API call anywhere in the app
/// detects that the user's session/access token is no longer valid
/// (a 401 response).
///
/// Why this exists: [AuthInterceptor] lives in the networking layer and
/// has no business knowing about [AuthBloc] or navigation. Instead of
/// wiring a direct dependency between them (which would break the
/// data -> domain -> presentation direction), the interceptor just calls
/// [notify] and [AuthBloc] subscribes to [onSessionExpired] to react -
/// clearing the cached session and sending the user back to the login
/// screen exactly once, instead of repeatedly failing on every future
/// app launch.
class SessionExpiredNotifier {
  SessionExpiredNotifier._internal();

  static final SessionExpiredNotifier instance =
      SessionExpiredNotifier._internal();

  final StreamController<void> _controller = StreamController<void>.broadcast();

  /// Whether a session-expired notification is already pending/being
  /// handled, so a burst of concurrent 401s (e.g. several requests in
  /// flight at once) only triggers a single logout instead of one per
  /// failed request.
  bool _hasPendingNotification = false;

  Stream<void> get onSessionExpired => _controller.stream;

  /// Called by [AuthInterceptor] when a request fails with a 401.
  void notify() {
    if (_hasPendingNotification || _controller.isClosed) return;
    _hasPendingNotification = true;
    _controller.add(null);
  }

  /// Called by [AuthBloc] once the session has been fully reset, either
  /// because the forced logout completed or because the user successfully
  /// logged back in. Re-arms [notify] for the next session.
  void reset() {
    _hasPendingNotification = false;
  }

  void dispose() {
    _controller.close();
  }
}
