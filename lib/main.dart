import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(const FlowApp());

const bg = Color(0xFFF4F7FB);
const ink = Color(0xFF172238);
const muted = Color(0xFF7C8798);
const blue = Color(0xFF526DDF);

class FlowApp extends StatelessWidget {
  const FlowApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flow Game Optimizer',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme.fromSeed(seedColor: blue),
    ),
    home: const FlowHome(),
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
          homePage(),
          const GamesPage(),
          const AimPage(),
          settingsPage(),
        ],
      ),
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: tab,
      onDestinationSelected: (v) => setState(() => tab = v),
      backgroundColor: Colors.white,
      indicatorColor: const Color(0xFFE6EBFF),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.grid_view_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.sports_esports_rounded),
          label: 'Games',
        ),
        NavigationDestination(
          icon: Icon(Icons.gps_fixed_rounded),
          label: 'Aim Lab',
        ),
        NavigationDestination(
          icon: Icon(Icons.tune_rounded),
          label: 'Settings',
        ),
      ],
    ),
  );

  Widget heading(String title, String subtitle) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.w800,
          color: ink,
          letterSpacing: -0.8,
        ),
      ),
      const SizedBox(height: 5),
      Text(subtitle, style: const TextStyle(color: muted, fontSize: 13)),
    ],
  );

  Widget glassCard(Widget child) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: .94),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: Colors.white, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: ink.withValues(alpha: .045),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: child,
  );

  Widget homePage() => ListView(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
    children: [
      Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF202E4C), blue],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.bolt_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FLOW',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    color: ink,
                  ),
                ),
                Text(
                  'GAME OPTIMIZER',
                  style: TextStyle(
                    fontSize: 10,
                    color: muted,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.circle, color: Color(0xFF39BD87), size: 10),
          const SizedBox(width: 6),
          const Text('Ready', style: TextStyle(color: muted, fontSize: 12)),
        ],
      ),
      const SizedBox(height: 28),
      heading('Play in your flow.', 'Your gaming space, simplified.'),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF263858), Color(0xFF536FE0)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'YOUR GAMING PROFILE',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              profile,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 29,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Balanced', 'Performance', 'Battery Saver']
                  .map(
                    (p) => ChoiceChip(
                      label: Text(p),
                      selected: profile == p,
                      onSelected: (_) => setState(() => profile = p),
                      selectedColor: Colors.white,
                      backgroundColor: Colors.white.withValues(alpha: .12),
                      labelStyle: TextStyle(
                        color: profile == p ? ink : Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                      showCheckmark: false,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      const SizedBox(height: 22),
      Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => setState(() => tab = 2),
              child: glassCard(
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.gps_fixed_rounded, color: blue, size: 28),
                    SizedBox(height: 14),
                    Text(
                      'FPS Arena',
                      style: TextStyle(
                        color: ink,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Train your aim',
                      style: TextStyle(color: muted, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: InkWell(
              onTap: () => setState(() => tab = 1),
              child: glassCard(
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.sports_esports_rounded,
                      color: blue,
                      size: 28,
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Game Library',
                      style: TextStyle(
                        color: ink,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Installed apps',
                      style: TextStyle(color: muted, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      glassCard(
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Session tools',
              style: TextStyle(
                color: ink,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Choose a profile to match your session. Profiles are presets only; they do not overclock CPU/GPU or guarantee higher FPS.',
              style: TextStyle(color: muted, height: 1.5, fontSize: 12),
            ),
          ],
        ),
      ),
    ],
  );

  Widget settingsPage() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      heading('Settings', 'Your app preferences.'),
      const SizedBox(height: 20),
      glassCard(
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Flow',
              style: TextStyle(
                color: ink,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Flow Game Optimizer • 1.1',
              style: TextStyle(color: muted),
            ),
            SizedBox(height: 10),
            Text(
              'Includes an aim-training mini-game and game-library placeholder. Native Android integration is required to discover and launch installed games.',
              style: TextStyle(color: muted, height: 1.5, fontSize: 12),
            ),
          ],
        ),
      ),
    ],
  );
}

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text(
        'Game Library',
        style: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.w800,
          color: ink,
        ),
      ),
      const SizedBox(height: 5),
      const Text(
        'Your game shortcuts in one place.',
        style: TextStyle(color: muted, fontSize: 13),
      ),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Column(
          children: [
            Icon(Icons.sports_esports_rounded, size: 42, color: blue),
            SizedBox(height: 12),
            Text(
              'Native integration needed',
              style: TextStyle(fontWeight: FontWeight.w800, color: ink),
            ),
            SizedBox(height: 8),
            Text(
              'This page is a UI placeholder. Listing and launching installed Android apps requires a native Android bridge and package visibility configuration.',
              textAlign: TextAlign.center,
              style: TextStyle(color: muted, height: 1.5, fontSize: 12),
            ),
          ],
        ),
      ),
    ],
  );
}

class AimPage extends StatefulWidget {
  const AimPage({super.key});

  @override
  State<AimPage> createState() => _AimPageState();
}

class _AimPageState extends State<AimPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  final random = math.Random();
  Offset target = const Offset(.5, .45);
  int shots = 0;
  int hits = 0;
  bool running = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..addListener(() {
        if (running && mounted) {
          setState(() {
            final t = controller.value * math.pi * 2;
            target = Offset(
              .5 + .31 * math.cos(t),
              .5 + .31 * math.sin(t * .77),
            );
          });
        }
      })
      ..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void shoot(Offset local, Size size) {
    if (!running) return;
    final p = Offset(local.dx / size.width, local.dy / size.height);
    setState(() {
      shots++;
      if ((p - target).distance < .105) {
        hits++;
        target = Offset(
          .12 + random.nextDouble() * .76,
          .15 + random.nextDouble() * .7,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text(
        'FPS Arena',
        style: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.w800,
          color: ink,
        ),
      ),
      const SizedBox(height: 5),
      const Text(
        'Drag or tap to train your aim.',
        style: TextStyle(color: muted, fontSize: 13),
      ),
      const SizedBox(height: 18),
      Row(
        children: [
          _stat('SHOTS', '$shots'),
          const SizedBox(width: 8),
          _stat('HITS', '$hits'),
          const SizedBox(width: 8),
          _stat('ACCURACY', '${shots == 0 ? 0 : (hits * 100 / shots).round()}%'),
        ],
      ),
      const SizedBox(height: 16),
      SizedBox(
        height: 360,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = Size(constraints.maxWidth, constraints.maxHeight);
            return GestureDetector(
              onPanDown: (d) => shoot(d.localPosition, size),
              onPanUpdate: (d) => shoot(d.localPosition, size),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Container(
                  color: const Color(0xFF263858),
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: size,
                        painter: ArenaGridPainter(),
                      ),
                      Positioned(
                        left: target.dx * size.width - 22,
                        top: target.dy * size.height - 22,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(
                              0xFFEF6F79,
                            ).withValues(alpha: .18),
                            border: Border.all(
                              color: const Color(0xFFFF9AA3),
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.circle,
                              color: Color(0xFFFF9AA3),
                              size: 13,
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 15,
                        top: 15,
                        child: Text(
                          'TRAINING RANGE / 01',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                            letterSpacing: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 14),
      Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => setState(() => running = !running),
              child: Text(running ? 'Pause' : 'Resume'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: FilledButton(
              onPressed: () => setState(() {
                shots = 0;
                hits = 0;
                target = const Offset(.5, .45);
              }),
              child: const Text('Reset'),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      const Text(
        'Training simulation only; it does not change aim settings in other games.',
        style: TextStyle(color: muted, fontSize: 11, height: 1.5),
      ),
    ],
  );

  Widget _stat(String label, String value) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: ink,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              color: muted,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    ),
  );
}

class ArenaGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.white.withValues(alpha: .07)
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
