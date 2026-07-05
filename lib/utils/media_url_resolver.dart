import '../core/networking/endpoints.dart';

/// Resolves relative media paths returned by the API (e.g.
/// `/uploads/images/1783173750446-322143549.png`) into absolute URLs that
/// can be used directly with [NetworkImage] / [Image.network].
///
/// Reuses [Endpoints.baseUrl] instead of hardcoding a new host, stripping the
/// `/api/v1` suffix since uploaded media is served from the host root.
abstract class MediaUrlResolver {
  const MediaUrlResolver._();

  static String resolve(String path) {
    if (path.isEmpty) return path;
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }

    final uri = Uri.parse(Endpoints.baseUrl);
    final host = '${uri.scheme}://${uri.authority}';

    return path.startsWith('/') ? '$host$path' : '$host/$path';
  }
}
