import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const FlowApp());

const bg = Color(0xFF080D18);
const panel = Color(0xFF111B2C);
const cyan = Color(0xFF59E1F2);
const blue = Color(0xFF6585FF);
const white = Color(0xFFF0F5FF);
const muted = Color(0xFF8493AA);
const bridge = MethodChannel('com.egii.flow/games');

class FlowApp extends StatelessWidget {
  const FlowApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flow Game Optimizer V2',
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: cyan,
        brightness: Brightness.dark,
      ),
      fontFamily: 'sans-serif',
    ),
    home: const FlowHome(),
  );
}

class GameInfo {
  final String name;
  final String packageName;
  final String? icon;
  const GameInfo({
    required this.name,
    required this.packageName,
    this.icon,
  });

  factory GameInfo.fromMap(Map<dynamic, dynamic> m) => GameInfo(
    name: m['name']?.toString() ?? 'Unknown app',
    packageName: m['packageName']?.toString() ?? '',
    icon: m['icon']?.toString(),
  );
}

class FlowHome extends StatefulWidget {
  const FlowHome({super.key});
  @override
  State<FlowHome> createState() => _FlowHomeState();
}

class _FlowHomeState extends State<FlowHome> {
  int tab = 0;
  String profile = 'Performance';

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: IndexedStack(
        index: tab,
        children: [
          HomePage(
            profile: profile,
            onProfile: (v) => setState(() => profile = v),
            onTab: (v) => setState(() => tab = v),
          ),
          const GamesPage(),
          const AimPage(),
          const SettingsPage(),
        ],
      ),
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: tab,
      onDestinationSelected: (v) => setState(() => tab = v),
      backgroundColor: const Color(0xFF0D1524),
      indicatorColor: cyan.withValues(alpha: .16),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.dashboard_rounded), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.sports_esports_rounded), label: 'Games'),
        NavigationDestination(icon: Icon(Icons.gps_fixed_rounded), label: 'Aim Lab'),
        NavigationDestination(icon: Icon(Icons.tune_rounded), label: 'Settings'),
      ],
    ),
  );
}

BoxDecoration glass({double radius = 22}) => BoxDecoration(
  color: Colors.white.withValues(alpha: .045),
  borderRadius: BorderRadius.circular(radius),
  border: Border.all(color: Colors.white.withValues(alpha: .09)),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withValues(alpha: .18),
      blurRadius: 24,
      offset: const Offset(0, 10),
    ),
  ],
);

Widget label(String s) => Text(
  s.toUpperCase(),
  style: const TextStyle(
    color: muted,
    fontSize: 10,
    letterSpacing: 1.8,
    fontWeight: FontWeight.w800,
  ),
);

Widget heading(String title, String subtitle) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(title, style: const TextStyle(
      color: white, fontSize: 28, fontWeight: FontWeight.w800,
      letterSpacing: -.8,
    )),
    const SizedBox(height: 5),
    Text(subtitle, style: const TextStyle(color: muted, fontSize: 13)),
  ],
);

class HomePage extends StatelessWidget {
  final String profile;
  final ValueChanged<String> onProfile;
  final ValueChanged<int> onTab;
  const HomePage({
    super.key, required this.profile, required this.onProfile,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
    children: [
      Row(children: [
        Container(
          width: 46, height: 46,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [cyan, blue]),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(Icons.bolt_rounded, color: bg, size: 30),
        ),
        const SizedBox(width: 12),
        const Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('FLOW', style: TextStyle(
              color: white, fontSize: 20, fontWeight: FontWeight.w900,
              letterSpacing: 3,
            )),
            Text('GAME OPTIMIZER', style: TextStyle(
              color: muted, fontSize: 9, letterSpacing: 2,
            )),
          ],
        )),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: glass(radius: 30),
          child: const Row(children: [
            Icon(Icons.circle, color: cyan, size: 7),
            SizedBox(width: 6),
            Text('READY', style: TextStyle(color: white, fontSize: 10)),
          ]),
        ),
      ]),
      const SizedBox(height: 32),
      heading('Play in your flow.', 'Your setup. Your session. Your pace.'),
      const SizedBox(height: 22),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFF172C48), Color(0xFF101827), Color(0xFF18213B)],
          ),
          border: Border.all(color: cyan.withValues(alpha: .24)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Icon(Icons.memory_rounded, color: cyan, size: 18),
            const SizedBox(width: 8),
            label('SESSION PRESET'),
          ]),
          const SizedBox(height: 15),
          Text(profile, style: const TextStyle(
            color: white, fontSize: 29, fontWeight: FontWeight.w800,
          )),
          const SizedBox(height: 18),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final p in ['Balanced', 'Performance', 'Battery Saver'])
              ChoiceChip(
                label: Text(p),
                selected: profile == p,
                onSelected: (_) => onProfile(p),
                selectedColor: cyan,
                backgroundColor: Colors.white.withValues(alpha: .05),
                labelStyle: TextStyle(
                  color: profile == p ? bg : white,
                  fontSize: 11, fontWeight: FontWeight.w700,
                ),
                side: BorderSide(
                  color: profile == p ? cyan : Colors.white24,
                ),
                showCheckmark: false,
              ),
          ]),
          const SizedBox(height: 16),
          const Text(
            'Preset pilihan sesi. Tidak melakukan overclock CPU/GPU.',
            style: TextStyle(color: muted, fontSize: 11),
          ),
        ]),
      ),
      const SizedBox(height: 26),
      label('QUICK ACCESS'),
      const SizedBox(height: 13),
      Row(children: [
        Expanded(child: ToolTile(
          icon: Icons.sports_esports_rounded,
          title: 'Game Library',
          subtitle: 'Launch installed apps',
          onTap: () => onTab(1),
        )),
        const SizedBox(width: 12),
        Expanded(child: ToolTile(
          icon: Icons.gps_fixed_rounded,
          title: 'Aim Lab',
          subtitle: 'Reaction training',
          onTap: () => onTab(2),
        )),
      ]),
      const SizedBox(height: 14),
      Container(
        padding: const EdgeInsets.all(18),
        decoration: glass(),
        child: const Row(children: [
          Icon(Icons.shield_outlined, color: cyan, size: 25),
          SizedBox(width: 12),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Built for your sessions', style: TextStyle(
                color: white, fontWeight: FontWeight.w800,
              )),
              SizedBox(height: 5),
              Text(
                'Quick access to games and a lightweight aim trainer.',
                style: TextStyle(color: muted, fontSize: 12, height: 1.5),
              ),
            ],
          )),
        ]),
      ),
    ],
  );
}

class ToolTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final VoidCallback onTap;
  const ToolTile({
    super.key, required this.icon, required this.title,
    required this.subtitle, required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(22),
    child: Container(
      padding: const EdgeInsets.all(17),
      decoration: glass(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: cyan, size: 27),
        const SizedBox(height: 20),
        Text(title, style: const TextStyle(
          color: white, fontWeight: FontWeight.w800, fontSize: 14,
        )),
        const SizedBox(height: 5),
        Text(subtitle, style: const TextStyle(color: muted, fontSize: 11)),
      ]),
    ),
  );
}

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});
  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  List<GameInfo> games = [];
  bool loading = false;
  String? error;
  String query = '';

  @override
  void initState() {
    super.initState();
    unawaited(loadGames());
  }

  Future<void> loadGames() async {
    setState(() { loading = true; error = null; });
    try {
      final raw = await bridge.invokeMethod<List<dynamic>>('getGames');
      final result = (raw ?? [])
          .whereType<Map>()
          .map((m) => GameInfo.fromMap(m))
          .toList()
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      if (mounted) setState(() => games = result);
    } on PlatformException catch (e) {
      if (mounted) setState(() => error = e.message ?? 'Native bridge error');
    } on MissingPluginException {
      if (mounted) setState(() => error = 'Native Android bridge belum tersedia di APK ini.');
    } catch (e) {
      if (mounted) setState(() => error = 'Gagal memuat aplikasi: $e');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> launchGame(GameInfo game) async {
    try {
      await bridge.invokeMethod('launchGame', {'packageName': game.packageName});
    } on PlatformException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Aplikasi tidak dapat dibuka')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final visible = games.where((g) =>
      g.name.toLowerCase().contains(query.toLowerCase()) ||
      g.packageName.toLowerCase().contains(query.toLowerCase())
    ).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      children: [
        Row(children: [
          Expanded(child: heading('Game Library', 'Your installed games in one place.')),
          IconButton(
            onPressed: loading ? null : loadGames,
            icon: const Icon(Icons.refresh_rounded, color: cyan),
            tooltip: 'Refresh',
          ),
        ]),
        const SizedBox(height: 22),
        Container(
          decoration: glass(radius: 17),
          child: TextField(
            onChanged: (v) => setState(() => query = v),
            style: const TextStyle(color: white),
            decoration: const InputDecoration(
              hintText: 'Search games and apps...',
              prefixIcon: Icon(Icons.search_rounded, color: muted),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(children: [
          label('Installed apps'),
          const Spacer(),
          Text('${visible.length} apps', style: const TextStyle(color: cyan, fontSize: 11)),
        ]),
        const SizedBox(height: 12),
        if (loading && games.isEmpty)
          const Padding(
            padding: EdgeInsets.all(36),
            child: Center(child: CircularProgressIndicator(color: cyan)),
          )
        else if (error != null)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: glass(),
            child: Column(children: [
              const Icon(Icons.info_outline_rounded, color: cyan, size: 32),
              const SizedBox(height: 12),
              Text(error!, textAlign: TextAlign.center,
                style: const TextStyle(color: white, height: 1.5)),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: loadGames,
                icon: const Icon(Icons.refresh),
                label: const Text('Try again'),
              ),
            ]),
          )
        else if (visible.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: glass(),
            child: Column(children: [
              const Icon(Icons.sports_esports_outlined, color: cyan, size: 42),
              const SizedBox(height: 12),
              Text(
                games.isEmpty ? 'No launchable apps found' : 'No matching apps',
                style: const TextStyle(color: white, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              const Text(
                'Tap refresh to check again. Only apps visible to Android and exposing a launch activity can appear.',
                textAlign: TextAlign.center,
                style: TextStyle(color: muted, fontSize: 12, height: 1.5),
              ),
            ]),
          )
        else
          for (final game in visible)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(13),
              decoration: glass(radius: 18),
              child: Row(children: [
                Container(
                  width: 47, height: 47,
                  decoration: BoxDecoration(
                    color: cyan.withValues(alpha: .10),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: game.icon != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.memory(
                            Uri.parse(game.icon!).data!.contentAsBytes(),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.videogame_asset_rounded, color: cyan),
                          ),
                        )
                      : const Icon(Icons.videogame_asset_rounded, color: cyan),
                ),
                const SizedBox(width: 12),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(game.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: white, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(game.packageName, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: muted, fontSize: 10)),
                  ],
                )),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: () => launchGame(game),
                  style: IconButton.styleFrom(
                    backgroundColor: cyan, foregroundColor: bg,
                  ),
                  icon: const Icon(Icons.play_arrow_rounded),
                  tooltip: 'Play',
                ),
              ]),
            ),
      ],
    );
  }
}

class AimPage extends StatefulWidget {
  const AimPage({super.key});
  @override
  State<AimPage> createState() => _AimPageState();
}

class _AimPageState extends State<AimPage> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  final random = math.Random();
  Offset target = const Offset(.5, .5);
  int shots = 0, hits = 0;
  bool running = false;
  int seconds = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    controller.addListener(() {
      if (running && mounted) setState(() {});
    });
  }

  void start() {
    timer?.cancel();
    setState(() {
      running = true; shots = 0; hits = 0; seconds = 30;
      target = Offset(.15 + random.nextDouble() * .7,
          .15 + random.nextDouble() * .7);
    });
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (seconds <= 1) {
        t.cancel();
        setState(() { seconds = 0; running = false; });
      } else {
        setState(() => seconds--);
      }
    });
  }

  void shoot(TapDownDetails d, Size size) {
    if (!running) return;
    final p = Offset(d.localPosition.dx / size.width, d.localPosition.dy / size.height);
    final distance = (p - target).distance;
    setState(() {
      shots++;
      if (distance < .095) hits++;
      target = Offset(.12 + random.nextDouble() * .76,
          .12 + random.nextDouble() * .76);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
    children: [
      heading('Aim Lab', 'Train your reaction and accuracy.'),
      const SizedBox(height: 20),
      Row(children: [
        _stat('TIME', '$seconds s'),
        const SizedBox(width: 10),
        _stat('SHOTS', '$shots'),
        const SizedBox(width: 10),
        _stat('HITS', '$hits'),
      ]),
      const SizedBox(height: 16),
      Container(
        height: 380,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color(0xFF0C1726),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: cyan.withValues(alpha: .3)),
        ),
        child: LayoutBuilder(builder: (context, c) {
          final size = Size(c.maxWidth, c.maxHeight);
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (d) => shoot(d, size),
            child: Stack(children: [
              Positioned.fill(child: CustomPaint(painter: GridPainter())),
              if (running)
                Positioned(
                  left: (target.dx * size.width - 25) + math.sin(controller.value * math.pi * 2) * 9,
                  top: target.dy * size.height - 25,
                  child: Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: cyan, width: 2),
                      boxShadow: [BoxShadow(color: cyan.withValues(alpha: .3), blurRadius: 18)],
                    ),
                    child: const Center(child: Icon(Icons.gps_fixed_rounded, color: cyan)),
                  ),
                ),
              if (!running)
                Center(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.gps_fixed_rounded, color: cyan, size: 46),
                    const SizedBox(height: 12),
                    Text(seconds == 0 ? 'Session complete' : 'Ready to aim?',
                      style: const TextStyle(color: white, fontWeight: FontWeight.w800, fontSize: 19)),
                    const SizedBox(height: 7),
                    const Text('Tap start, then hit the moving target.',
                      style: TextStyle(color: muted, fontSize: 12)),
                    const SizedBox(height: 18),
                    FilledButton(
                      onPressed: start,
                      style: FilledButton.styleFrom(backgroundColor: cyan, foregroundColor: bg),
                      child: const Text('Start 30s session'),
                    ),
                  ],
                )),
            ]),
          );
        }),
      ),
      const SizedBox(height: 12),
      Text(
        'Accuracy: ${shots == 0 ? 0 : (hits * 100 / shots).round()}%',
        textAlign: TextAlign.center,
        style: const TextStyle(color: cyan, fontWeight: FontWeight.w800),
      ),
    ],
  );

  Widget _stat(String title, String value) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(13),
      decoration: glass(radius: 16),
      child: Column(children: [
        label(title),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(color: white, fontWeight: FontWeight.w800)),
      ]),
    ),
  );
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = cyan.withValues(alpha: .07)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 28) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      heading('Settings', 'Your app, your preferences.'),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: glass(),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.bolt_rounded, color: cyan, size: 30),
            SizedBox(height: 14),
            Text('Flow Game Optimizer V2', style: TextStyle(
              color: white, fontSize: 18, fontWeight: FontWeight.w800)),
            SizedBox(height: 8),
            Text('Version 2.1 • V2 package verification',
              style: TextStyle(color: muted)),
            SizedBox(height: 14),
            Text(
              'Flow provides game shortcuts and an aim-training mini-game. Profiles are UI presets and do not guarantee higher FPS or change CPU/GPU clocks.',
              style: TextStyle(color: muted, fontSize: 12, height: 1.6),
            ),
          ],
        ),
      ),
    ],
  );
}
