import 'package:flutter/material.dart';

void main() => runApp(const FlowApp());

const ink = Color(0xFF17233B);
const blue = Color(0xFF4263EB);
const muted = Color(0xFF78839A);
const canvas = Color(0xFFF5F7FC);

class FlowApp extends StatelessWidget {
  const FlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flow Game Optimizer',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: canvas,
        colorScheme: ColorScheme.fromSeed(seedColor: blue),
        fontFamily: 'Roboto',
      ),
      home: const FlowHome(),
    );
  }
}

class FlowHome extends StatefulWidget {
  const FlowHome({super.key});

  @override
  State<FlowHome> createState() => _FlowHomeState();
}

class _FlowHomeState extends State<FlowHome> {
  int tab = 0;
  int score = 0;
  int target = 0;

  final pages = const ['Home', 'Games', 'Aim Lab', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: tab,
          children: [
            homePage(),
            gamesPage(),
            aimPage(),
            settingsPage(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE8EDFF),
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.sports_esports_rounded), label: 'Games'),
          NavigationDestination(icon: Icon(Icons.gps_fixed_rounded), label: 'Aim Lab'),
          NavigationDestination(icon: Icon(Icons.tune_rounded), label: 'Settings'),
        ],
      ),
    );
  }

  Widget heading(String title, String subtitle) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w800, color: ink, letterSpacing: -0.8)),
      const SizedBox(height: 5),
      Text(subtitle, style: const TextStyle(color: muted, fontSize: 13)),
    ],
  );

  Widget homePage() => ListView(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
    children: [
      Row(children: [
        Container(
          width: 46, height: 46,
          decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(15)),
          child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 29),
        ),
        const SizedBox(width: 12),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('FLOW', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, letterSpacing: 2, color: ink)),
          Text('GAME OPTIMIZER', style: TextStyle(fontSize: 10, color: muted, letterSpacing: 1.5)),
        ])),
        const Icon(Icons.circle, color: Color(0xFF39BD87), size: 10),
        const SizedBox(width: 6),
        const Text('Ready', style: TextStyle(color: muted, fontSize: 12)),
      ]),
      const SizedBox(height: 28),
      heading('Play in your flow.', 'Your gaming space, simplified.'),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF243B73), Color(0xFF4263EB)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.bolt_rounded, color: Color(0xFFBFD0FF), size: 27),
          const SizedBox(height: 15),
          const Text('READY WHEN YOU ARE', style: TextStyle(color: Color(0xFFCFD9FF), fontSize: 10, letterSpacing: 1.7, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Make every session\\nyour own.', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800, height: 1.2)),
          const SizedBox(height: 10),
          const Text('Tools and practice in one place.', style: TextStyle(color: Color(0xFFE0E7FF), fontSize: 13)),
          const SizedBox(height: 20),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: ink),
            onPressed: () => setState(() => tab = 2),
            child: const Text('Open Aim Lab'),
          ),
        ]),
      ),
      const SizedBox(height: 25),
      const Text('QUICK ACCESS', style: TextStyle(color: muted, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
      const SizedBox(height: 13),
      Row(children: [
        Expanded(child: quickCard(Icons.sports_esports_rounded, 'Game library', 'Your installed games', () => setState(() => tab = 1))),
        const SizedBox(width: 12),
        Expanded(child: quickCard(Icons.gps_fixed_rounded, 'Aim training', 'Practice your accuracy', () => setState(() => tab = 2))),
      ]),
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: const Row(children: [
          Icon(Icons.info_outline_rounded, color: blue, size: 25),
          SizedBox(width: 12),
          Expanded(child: Text('Flow provides practice tools and device guidance. Actual game performance depends on your device and game.', style: TextStyle(color: muted, fontSize: 12, height: 1.5))),
        ]),
      ),
    ],
  );

  Widget quickCard(IconData icon, String title, String subtitle, VoidCallback onTap) =>
    Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(icon, color: blue, size: 25),
            const SizedBox(height: 17),
            Text(title, style: const TextStyle(color: ink, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 5),
            Text(subtitle, style: const TextStyle(color: muted, fontSize: 11)),
          ]),
        ),
      ),
    );

  Widget gamesPage() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      heading('Game library', 'Your games, all in one place.'),
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Column(children: [
          Container(
            height: 74, width: 74,
            decoration: BoxDecoration(color: const Color(0xFFEDF1FF), borderRadius: BorderRadius.circular(23)),
            child: const Icon(Icons.sports_esports_rounded, size: 38, color: blue),
          ),
          const SizedBox(height: 18),
          const Text('Game detection coming next', style: TextStyle(color: ink, fontWeight: FontWeight.bold, fontSize: 17)),
          const SizedBox(height: 8),
          const Text('This starter version does not yet scan installed game packages. The next step is Android integration to detect launchable games and open them safely.', textAlign: TextAlign.center, style: TextStyle(color: muted, fontSize: 13, height: 1.6)),
          const SizedBox(height: 18),
          OutlinedButton.icon(onPressed: () => setState(() => tab = 3), icon: const Icon(Icons.info_outline), label: const Text('View app details')),
        ]),
      ),
    ],
  );

  Widget aimPage() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      heading('Aim Lab', 'A small reaction and accuracy drill.'),
      const SizedBox(height: 18),
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(23)),
        child: Row(children: [
          Expanded(child: stat('SCORE', '$score')),
          Expanded(child: stat('TARGETS', '$target')),
          Expanded(child: stat('MODE', 'TAP')),
        ]),
      ),
      const SizedBox(height: 18),
      const Text('Tap the target to score points. This is an in-app training demo, not an overlay inside other games.', style: TextStyle(color: muted, fontSize: 13, height: 1.5)),
      const SizedBox(height: 14),
      Container(
        height: 340,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFFE7EBF4))),
        child: LayoutBuilder(builder: (context, c) => Stack(children: [
          const Positioned(left: 18, top: 18, child: Text('TRAINING ZONE', style: TextStyle(color: muted, fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.bold))),
          Positioned(
            left: 20 + ((target * 53) % 190).toDouble().clamp(0, (c.maxWidth - 78).clamp(0, 500)),
            top: 65 + ((target * 71) % 205).toDouble().clamp(0, (c.maxHeight - 125).clamp(0, 300)),
            child: GestureDetector(
              onTap: () => setState(() { score += 10; target++; }),
              child: Container(
                width: 54, height: 54,
                decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFE9EDFF), border: Border.all(color: blue, width: 3)),
                child: const Center(child: Icon(Icons.gps_fixed_rounded, color: blue, size: 28)),
              ),
            ),
          ),
          Positioned(bottom: 16, left: 0, right: 0, child: Center(child: Text('TAP THE TARGET  •  +10 POINTS', style: TextStyle(color: muted, fontSize: 10, letterSpacing: 1)))),
        ])),
      ),
      const SizedBox(height: 14),
      OutlinedButton.icon(
        onPressed: () => setState(() { score = 0; target = 0; }),
        icon: const Icon(Icons.refresh_rounded),
        label: const Text('Reset training'),
      ),
    ],
  );

  Widget stat(String label, String value) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: const TextStyle(color: Color(0xFFBFCBF0), fontSize: 9, letterSpacing: 1.2)),
    const SizedBox(height: 7),
    Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
  ]);

  Widget settingsPage() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      heading('Settings', 'Your Flow experience.'),
      const SizedBox(height: 22),
      settingTile(Icons.bolt_rounded, 'Flow Game Optimizer', 'Version 1.0.0'),
      settingTile(Icons.phone_android_rounded, 'Device tools', 'Performance monitoring is not enabled yet'),
      settingTile(Icons.privacy_tip_outlined, 'Privacy', 'No account or sign-in required'),
      settingTile(Icons.info_outline_rounded, 'About Flow', 'Independent gaming companion and aim practice app'),
      const SizedBox(height: 18),
      const Text('Flow cannot guarantee FPS increases or change the internal behavior of third-party games. Use only supported Android features.', style: TextStyle(color: muted, fontSize: 12, height: 1.6)),
    ],
  );

  Widget settingTile(IconData icon, String title, String subtitle) => Container(
    margin: const EdgeInsets.only(bottom: 11),
    padding: const EdgeInsets.all(17),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
    child: Row(children: [
      Container(width: 43, height: 43, decoration: BoxDecoration(color: const Color(0xFFEDF1FF), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: blue)),
      const SizedBox(width: 13),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: ink, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(color: muted, fontSize: 11)),
      ])),
    ]),
  );
}
