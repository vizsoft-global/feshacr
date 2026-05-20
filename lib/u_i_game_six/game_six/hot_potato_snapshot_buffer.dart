import 'dart:ui' show Offset;

/// Ring buffer of timestamped snapshots for delayed interpolation.
class HotPotatoSnapshotBuffer {
  HotPotatoSnapshotBuffer({this.maxSnapshots = 24});

  final int maxSnapshots;
  final List<_Snap> _snaps = [];

  void push({
    required int serverTimeMs,
    required double x,
    required double y,
    required double vx,
    required double vy,
  }) {
    if (_snaps.isNotEmpty && serverTimeMs <= _snaps.last.t) {
      // Replace duplicate/out-of-order tick.
      final last = _snaps.last;
      if (serverTimeMs == last.t) {
        _snaps[_snaps.length - 1] = _Snap(serverTimeMs, x, y, vx, vy);
        return;
      }
    }
    _snaps.add(_Snap(serverTimeMs, x, y, vx, vy));
    while (_snaps.length > maxSnapshots) {
      _snaps.removeAt(0);
    }
  }

  void clear() => _snaps.clear();

  /// [renderTimeMs] = now - bufferDelayMs
  Offset? sampleAt(int renderTimeMs) {
    if (_snaps.isEmpty) return null;
    if (_snaps.length == 1) {
      final s = _snaps.first;
      return Offset(s.x, s.y);
    }
    if (renderTimeMs <= _snaps.first.t) {
      final s = _snaps.first;
      return Offset(s.x, s.y);
    }
    final last = _snaps.last;
    if (renderTimeMs >= last.t) {
      // Brief extrapolation using velocity.
      final dt = (renderTimeMs - last.t) / 1000.0;
      return Offset(
        (last.x + last.vx * dt).clamp(0.04, 0.96),
        (last.y + last.vy * dt).clamp(0.04, 0.96),
      );
    }
    for (var i = 0; i < _snaps.length - 1; i++) {
      final a = _snaps[i];
      final b = _snaps[i + 1];
      if (a.t <= renderTimeMs && renderTimeMs <= b.t) {
        final span = (b.t - a.t).clamp(1, 1 << 30);
        final u = (renderTimeMs - a.t) / span;
        return Offset(
          a.x + (b.x - a.x) * u,
          a.y + (b.y - a.y) * u,
        );
      }
    }
    return Offset(last.x, last.y);
  }
}

class _Snap {
  _Snap(this.t, this.x, this.y, this.vx, this.vy);
  final int t;
  final double x;
  final double y;
  final double vx;
  final double vy;
}

/// Per-participant buffers for edge state frames.
class HotPotatoSnapshotInterpolator {
  HotPotatoSnapshotInterpolator({this.bufferDelayMs = 110});

  final int bufferDelayMs;
  final Map<String, HotPotatoSnapshotBuffer> _byPath = {};

  void ingest({
    required String path,
    required int serverTimeMs,
    required double x,
    required double y,
    required double vx,
    required double vy,
  }) {
    final buf = _byPath.putIfAbsent(path, HotPotatoSnapshotBuffer.new);
    buf.push(
      serverTimeMs: serverTimeMs,
      x: x,
      y: y,
      vx: vx,
      vy: vy,
    );
  }

  void removePath(String path) => _byPath.remove(path);

  void clear() => _byPath.clear();

  Offset? displayPosition(String path, {int? nowMs}) {
    final buf = _byPath[path];
    if (buf == null) return null;
    final now = nowMs ?? DateTime.now().millisecondsSinceEpoch;
    return buf.sampleAt(now - bufferDelayMs);
  }

  Map<String, Offset> allDisplayPositions({int? nowMs}) {
    final out = <String, Offset>{};
    for (final path in _byPath.keys) {
      final p = displayPosition(path, nowMs: nowMs);
      if (p != null) out[path] = p;
    }
    return out;
  }
}
