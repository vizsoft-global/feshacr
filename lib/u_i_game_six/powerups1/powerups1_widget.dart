import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/u_i_game_six/game_six/hot_potato_edge_client.dart';
import '/u_i_game_six/game_six/hot_potato_live.dart';
import '/u_i_game_six/game_six/hot_potato_positions_rtdb.dart';
import '/u_i_game_six/game_six/hot_potato_rtdb_routing.dart';
import '/u_i_game_six/game_six/hot_potato_settings_parser.dart';
import '/u_i_game_six/game_six/hot_potato_sfx.dart';
import 'dart:async';
import '/u_i_game_six/game_six/hot_potato_haptics.dart';
import 'package:flutter/material.dart';
import 'powerups1_model.dart';
export 'powerups1_model.dart';

/// Arena HUD: inventory counts; players can consume any stocked power-up.
class Powerups1Widget extends StatefulWidget {
  const Powerups1Widget({
    super.key,
    required this.allowedPowerups,
    required this.roomRef,
    required this.live,
    required this.settings,
    required this.canUsePowerup,
  });

  final List<String> allowedPowerups;
  final DocumentReference roomRef;
  final HotPotatoLiveState? live;
  final HotPotatoFirestoreSettings settings;
  final bool canUsePowerup;

  @override
  State<Powerups1Widget> createState() => _Powerups1WidgetState();
}

class _Powerups1WidgetState extends State<Powerups1Widget> {
  late Powerups1Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Powerups1Model());
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  /// Emoji glyphs paired with each powerup. Material `Icons.*` were rendering
  /// as low-contrast / sometimes-blank glyphs on real Android devices because
  /// the icon color was the room's accent against the dark pill background.
  /// Emoji always render, every platform, no font dependency.
  String _emojiFor(String id) {
    switch (id) {
      case 'Speed':
        return '⚡';
      case 'Banana':
      case 'BananaTrap':
        return '🍌';
      case 'Shield':
        return '🛡️';
      case 'Ghost':
      case 'Unseen':
        return '👻';
      default:
        return '🎁';
    }
  }

  /// Background color of each powerup's circle. Picked to match the colors
  /// used elsewhere in Hot Potato so icons are easy to recognize across
  /// settings, the field, and the inventory.
  Color _bgFor(String id) {
    switch (id) {
      case 'Speed':
        return const Color(0xFFE74C3C); // red
      case 'Banana':
      case 'BananaTrap':
        return const Color(0xFFF1C40F); // yellow
      case 'Shield':
        return const Color(0xFFF39C12); // gold
      case 'Ghost':
      case 'Unseen':
        return const Color(0xFF9B59B6); // purple
      default:
        return const Color(0xFF7F8C8D);
    }
  }

  Future<void> _onPowerup(String id) async {
    final live = widget.live;
    if (live == null || live.matchComplete || !widget.canUsePowerup) return;
    // Powerups belong to whoever picked them up; non-holders can use them too.
    final me = currentUserReference?.path;
    if (me == null) return;
    final canonicalId = id == 'Unseen' ? 'Ghost' : id;
    if (canonicalId != 'Speed' &&
        canonicalId != 'Shield' &&
        canonicalId != 'Ghost' &&
        canonicalId != 'Banana') {
      return;
    }
    final n = (() {
      final edge = HotPotatoEdgePowerRelay.clientFor(widget.roomRef.id);
      if (widget.settings.edgeRealtime && edge?.edgeInventory != null) {
        return edge!.edgeInventoryCount(me, canonicalId);
      }
      return live.inventoryCount(me, canonicalId);
    })();
    if (n < 1) return;
    final now = DateTime.now();
    final mePos = live.positionFor(me) ??
        const HotPotatoPositionData(x: 0.5, y: 0.5, vx: 0, vy: 0);
    if (canonicalId == 'Speed' ||
        canonicalId == 'Shield' ||
        canonicalId == 'Ghost' ||
        canonicalId == 'Banana') {
      if (widget.settings.edgeRealtime) {
        final edge = HotPotatoEdgePowerRelay.clientFor(widget.roomRef.id);
        HotPotatoSfx.playPowerup();
        HotPotatoHaptics.medium();
        edge?.optimisticUsePower(
          path: me,
          kind: canonicalId,
        );
        edge?.usePower(
          path: me,
          kind: canonicalId,
        );
        return;
      } else if (canonicalId == 'Speed' || canonicalId == 'Shield') {
        HotPotatoSfx.playPowerup();
        HotPotatoHaptics.medium();
        unawaited(
          HotPotatoRtdbPositions.writePosition(
            databaseUrl: hotPotatoEffectiveDatabaseUrl(live.rtdbDatabaseUrl),
            roomId: widget.roomRef.id,
            path: me,
            x: mePos.x,
            y: mePos.y,
            vx: mePos.vx,
            vy: mePos.vy,
            speedUntil: canonicalId == 'Speed'
                ? now.add(const Duration(seconds: 5))
                : mePos.speedUntil,
            shieldUntil: canonicalId == 'Shield'
                ? now.add(const Duration(seconds: 5))
                : mePos.shieldUntil,
          ),
        );
      }
    }
    if (widget.settings.edgeRealtime) return;
    if (canonicalId == 'Ghost' || canonicalId == 'Banana') {
      HotPotatoSfx.playPowerup();
      HotPotatoHaptics.medium();
    }
    try {
      await HotPotatoLiveFirestore.consumeInventory(
        widget.roomRef,
        me,
        canonicalId,
      );
    } catch (_) {
      // Silent failure: avoid disruptive toasts during active play.
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.allowedPowerups.isEmpty) {
      return const SizedBox.shrink();
    }

    final live = widget.live;
    final me = currentUserReference?.path;
    final bottomPad = 10.0 + MediaQuery.paddingOf(context).bottom;

    final bar = Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 12, bottomPad),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < widget.allowedPowerups.length; i++) ...[
              () {
                final id = widget.allowedPowerups[i];
                final canonicalId = id == 'Unseen' ? 'Ghost' : id;
                final stock = (live != null && me != null)
                    ? (() {
                        final edge =
                            HotPotatoEdgePowerRelay.clientFor(widget.roomRef.id);
                        if (widget.settings.edgeRealtime &&
                            edge?.edgeInventory != null) {
                          return edge!.edgeInventoryCount(me, canonicalId);
                        }
                        return live.inventoryCount(me, canonicalId);
                      })()
                    : 0;
                final isSupported = canonicalId == 'Speed' ||
                    canonicalId == 'Shield' ||
                    canonicalId == 'Ghost' ||
                    canonicalId == 'Banana';
                final usable = widget.canUsePowerup &&
                    isSupported &&
                    stock > 0 &&
                    live != null &&
                    !live.matchComplete;
                return _PowerupSegment(
                  emoji: _emojiFor(id),
                  bgColor: _bgFor(id),
                  count: stock,
                  enabled: usable,
                  isSupported: isSupported,
                  onTap: () => _onPowerup(id),
                );
              }(),
              if (i < widget.allowedPowerups.length - 1)
                const SizedBox(width: 10),
            ],
          ],
        ),
      ),
    );

    final edge = widget.settings.edgeRealtime
        ? HotPotatoEdgePowerRelay.clientFor(widget.roomRef.id)
        : null;
    if (edge != null) {
      return ValueListenableBuilder<int>(
        valueListenable: edge.simRevision,
        builder: (_, __, ___) => bar,
      );
    }
    return bar;
  }
}

class _PowerupSegment extends StatefulWidget {
  const _PowerupSegment({
    required this.emoji,
    required this.bgColor,
    required this.count,
    required this.enabled,
    required this.isSupported,
    required this.onTap,
  });

  final String emoji;
  final Color bgColor;
  final int count;
  final bool enabled;

  /// Kept for unknown/legacy ids; unsupported chips are greyed and show "SOON".
  final bool isSupported;
  final VoidCallback onTap;

  @override
  State<_PowerupSegment> createState() => _PowerupSegmentState();
}

class _PowerupSegmentState extends State<_PowerupSegment>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dim = !widget.enabled;
    return GestureDetector(
      onTap: widget.enabled ? widget.onTap : null,
      child: AnimatedBuilder(
        animation: _pulseCtrl,
        builder: (context, _) {
          final p = _pulseCtrl.value;
          final scale = widget.enabled ? 1.0 + p * 0.07 : 1.0;
          final glowA = dim ? 0.12 : (0.35 + p * 0.35);
          final blur = dim ? 4.0 : (10.0 + p * 14.0);
          return Transform.scale(
            scale: scale,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: widget.bgColor.withValues(alpha: glowA * 0.5),
                          blurRadius: blur,
                          spreadRadius: dim ? 0 : 0.5 + p * 2.5,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: dim
                          ? widget.bgColor.withValues(alpha: 0.42)
                          : widget.bgColor,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: dim ? 0.5 : 0.95),
                        width: 2.2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.emoji,
                      style: const TextStyle(fontSize: 24, height: 1.0),
                    ),
                  ),
                  if (widget.count > 0)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: widget.bgColor, width: 1.5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.count}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: widget.bgColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
