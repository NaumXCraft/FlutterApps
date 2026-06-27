import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const DemoApp());
}

// ─── Цветовая схема ───────────────────────────────────────────────
class AppColors {
  static const bg = Color(0xFF0D0F14);
  static const surface = Color(0xFF161A22);
  static const card = Color(0xFF1E2430);
  static const accent = Color(0xFF6C63FF);
  static const accentSoft = Color(0xFF9D97FF);
  static const teal = Color(0xFF00D4AA);
  static const coral = Color(0xFFFF6B6B);
  static const amber = Color(0xFFFFB347);
  static const textPrimary = Color(0xFFF0F2F8);
  static const textSecondary = Color(0xFF8892A4);
  static const divider = Color(0xFF252B38);
}

// ─── Корневой виджет ──────────────────────────────────────────────
class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: ColorScheme.dark(
          primary: AppColors.accent,
          surface: AppColors.surface,
        ),
        fontFamily: 'Roboto',
      ),
      home: const MainScreen(),
    );
  }
}

// ─── Главный экран с Tab-навигацией ──────────────────────────────
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  final List<_TabItem> _tabs = const [
    _TabItem(icon: Icons.home_rounded, label: 'Home'),
    _TabItem(icon: Icons.explore_rounded, label: 'Explore'),
    _TabItem(icon: Icons.bar_chart_rounded, label: 'Stats'),
    _TabItem(icon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this)
      ..addListener(() {
        setState(() => _currentIndex = _tabController.index);
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: const BouncingScrollPhysics(),
        children: const [
          HomeTab(),
          ExploreTab(),
          StatsTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: _BottomNav(
        tabs: _tabs,
        currentIndex: _currentIndex,
        onTap: (i) => _tabController.animateTo(i),
      ),
    );
  }
}

class _TabItem {
  final IconData icon;
  final String label;
  const _TabItem({required this.icon, required this.label});
}

// ─── Нижняя навигация ─────────────────────────────────────────────
class _BottomNav extends StatelessWidget {
  final List<_TabItem> tabs;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabs.length, (i) {
          final selected = i == currentIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.accent.withOpacity(0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedScale(
                    scale: selected ? 1.15 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      tabs[i].icon,
                      color: selected
                          ? AppColors.accent
                          : AppColors.textSecondary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: selected
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color: selected
                          ? AppColors.accent
                          : AppColors.textSecondary,
                    ),
                    child: Text(tabs[i].label),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// TAB 1 — HOME
// ══════════════════════════════════════════════════════════════════
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  late AnimationController _heroCtrl;
  late Animation<double> _heroFade;
  late Animation<Offset> _heroSlide;

  @override
  void initState() {
    super.initState();
    _heroCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _heroFade = CurvedAnimation(parent: _heroCtrl, curve: Curves.easeOut);
    _heroSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _heroCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _heroCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // App Bar
        SliverAppBar(
          pinned: true,
          backgroundColor: AppColors.bg,
          elevation: 0,
          expandedHeight: 0,
          title: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.accent, AppColors.teal],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.bolt_rounded,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              const Text('Pulse',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  )),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined,
                  color: AppColors.textSecondary),
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.accent.withOpacity(0.2),
                child: const Text('А',
                    style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero блок
                FadeTransition(
                  opacity: _heroFade,
                  child: SlideTransition(
                    position: _heroSlide,
                    child: _HeroCard(),
                  ),
                ),

                const SizedBox(height: 28),

                // Quick stats
                const Text('Обзор',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                        child: _StatCard(
                      label: 'Активность',
                      value: '8 742',
                      unit: 'шагов',
                      icon: Icons.directions_walk_rounded,
                      color: AppColors.teal,
                    )),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _StatCard(
                      label: 'Калории',
                      value: '342',
                      unit: 'ккал',
                      icon: Icons.local_fire_department_rounded,
                      color: AppColors.coral,
                    )),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                        child: _StatCard(
                      label: 'Сон',
                      value: '7.5',
                      unit: 'ч',
                      icon: Icons.bedtime_rounded,
                      color: AppColors.accent,
                    )),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _StatCard(
                      label: 'Пульс',
                      value: '72',
                      unit: 'уд/мин',
                      icon: Icons.favorite_rounded,
                      color: AppColors.amber,
                    )),
                  ],
                ),

                const SizedBox(height: 28),

                // Activity feed
                const Text('Последнее',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(height: 14),
                ..._activities.map((a) => _ActivityTile(activity: a)),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3D35A8), Color(0xFF6C63FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.35),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Пятница, 27 июня',
                style: TextStyle(color: Colors.white70, fontSize: 12)),
          ),
          const SizedBox(height: 16),
          const Text('Добрый день,\nАлексей! 👋',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                height: 1.2,
                letterSpacing: -0.5,
              )),
          const SizedBox(height: 16),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _HeroStat(label: 'Цель', value: '10 000', suffix: 'шаг'),
              _HeroStat(label: 'Выполнено', value: '87', suffix: '%'),
              _HeroStat(label: 'Серия', value: '12', suffix: 'дней'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  final String label, value, suffix;
  const _HeroStat(
      {required this.label, required this.value, required this.suffix});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white54, fontSize: 11)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800)),
            const SizedBox(width: 3),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(suffix,
                  style: const TextStyle(color: Colors.white60, fontSize: 12)),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, value, unit;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 12),
          Text(label,
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 12)),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: ' $unit',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Activity {
  final String title, subtitle, time;
  final IconData icon;
  final Color color;
  const _Activity(
      {required this.title,
      required this.subtitle,
      required this.time,
      required this.icon,
      required this.color});
}

const _activities = [
  _Activity(
    title: 'Утренняя пробежка',
    subtitle: '5.2 км • 28 мин',
    time: '07:30',
    icon: Icons.directions_run_rounded,
    color: AppColors.teal,
  ),
  _Activity(
    title: 'Тренировка',
    subtitle: 'Грудь и спина • 45 мин',
    time: '12:00',
    icon: Icons.fitness_center_rounded,
    color: AppColors.coral,
  ),
  _Activity(
    title: 'Медитация',
    subtitle: '10 мин сессия',
    time: '20:15',
    icon: Icons.self_improvement_rounded,
    color: AppColors.accent,
  ),
];

class _ActivityTile extends StatelessWidget {
  final _Activity activity;
  const _ActivityTile({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: activity.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(activity.icon, color: activity.color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.title,
                    style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
                const SizedBox(height: 3),
                Text(activity.subtitle,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Text(activity.time,
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// TAB 2 — EXPLORE (карточки с горизонтальным скроллом)
// ══════════════════════════════════════════════════════════════════
class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  int _selectedCategory = 0;

  final _categories = [
    'Все', 'Бег', 'Йога', 'Сила', 'Питание', 'Ментальность'
  ];

  final _workouts = [
    _WorkoutData('Утренний старт', '20 мин', 'Начинающий',
        AppColors.teal, Icons.wb_sunny_rounded),
    _WorkoutData('HIIT Пресс', '35 мин', 'Средний',
        AppColors.coral, Icons.flash_on_rounded),
    _WorkoutData('Йога Flow', '45 мин', 'Начинающий',
        AppColors.accent, Icons.self_improvement_rounded),
    _WorkoutData('Силовая', '60 мин', 'Сложный',
        AppColors.amber, Icons.fitness_center_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: AppColors.bg,
          expandedHeight: 0,
          title: const Text('Исследовать',
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5)),
          actions: [
            IconButton(
              icon: const Icon(Icons.search_rounded,
                  color: AppColors.textSecondary),
              onPressed: () {},
            ),
          ],
        ),

        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Категории
              SizedBox(
                height: 48,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _categories.length,
                  itemBuilder: (_, i) {
                    final sel = i == _selectedCategory;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: sel ? AppColors.accent : AppColors.card,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              color: sel
                                  ? AppColors.accent
                                  : AppColors.divider),
                        ),
                        child: Text(_categories[i],
                            style: TextStyle(
                              color: sel
                                  ? Colors.white
                                  : AppColors.textSecondary,
                              fontSize: 13,
                              fontWeight: sel
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                            )),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Featured banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _FeaturedBanner(),
              ),

              const SizedBox(height: 24),

              // Workout cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text('Тренировки',
                    style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _workouts.length,
                  itemBuilder: (_, i) => _WorkoutCard(data: _workouts[i]),
                ),
              ),

              const SizedBox(height: 24),

              // List items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text('Популярное',
                    style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 14),
              ..._popularItems.map((item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _PopularTile(item: item),
              )),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }
}

class _WorkoutData {
  final String title, duration, level;
  final Color color;
  final IconData icon;
  const _WorkoutData(
      this.title, this.duration, this.level, this.color, this.icon);
}

class _WorkoutCard extends StatelessWidget {
  final _WorkoutData data;
  const _WorkoutCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: data.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(data.icon, color: data.color, size: 24),
            ),
            const Spacer(),
            Text(data.title,
                style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
                maxLines: 2),
            const SizedBox(height: 6),
            Text(data.duration,
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 12)),
            const SizedBox(height: 4),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: data.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(data.level,
                  style: TextStyle(
                      color: data.color,
                      fontSize: 11,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF004D40), Color(0xFF00D4AA)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('АКЦИЯ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 10),
                const Text('30-дневный\nвызов!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        height: 1.2)),
                const SizedBox(height: 8),
                const Text('Прими участие и выиграй\nпремиум подписку',
                    style:
                        TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    elevation: 0,
                  ),
                  child: const Text('Подробнее',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 13)),
                ),
              ],
            ),
          ),
          const Icon(Icons.emoji_events_rounded,
              color: Colors.white, size: 80),
        ],
      ),
    );
  }
}

class _PopularItem {
  final String title, sub;
  final IconData icon;
  final Color color;
  final String badge;
  const _PopularItem(this.title, this.sub, this.icon, this.color, this.badge);
}

const _popularItems = [
  _PopularItem('Протеиновый смузи', 'Питание • 5 мин',
      Icons.local_drink_rounded, AppColors.teal, '★ 4.9'),
  _PopularItem('Техника бега', 'Бег • 15 мин',
      Icons.directions_run_rounded, AppColors.coral, '★ 4.7'),
  _PopularItem('Дыхательные практики', 'Ментальность • 10 мин',
      Icons.air_rounded, AppColors.accent, '★ 4.8'),
];

class _PopularTile extends StatelessWidget {
  final _PopularItem item;
  const _PopularTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(item.icon, color: item.color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title,
                    style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
                const SizedBox(height: 3),
                Text(item.sub,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.amber.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(item.badge,
                style: const TextStyle(
                    color: AppColors.amber,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// TAB 3 — STATS (анимированный график)
// ══════════════════════════════════════════════════════════════════
class StatsTab extends StatefulWidget {
  const StatsTab({super.key});

  @override
  State<StatsTab> createState() => _StatsTabState();
}

class _StatsTabState extends State<StatsTab>
    with SingleTickerProviderStateMixin {
  late AnimationController _chartCtrl;
  late Animation<double> _chartAnim;

  final _weekData = [6200, 8100, 7400, 10200, 9100, 8742, 5300];
  final _days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
  int _selectedPeriod = 0;
  final _periods = ['Неделя', 'Месяц', 'Год'];

  @override
  void initState() {
    super.initState();
    _chartCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..forward();
    _chartAnim =
        CurvedAnimation(parent: _chartCtrl, curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    _chartCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: AppColors.bg,
          expandedHeight: 0,
          title: const Text('Статистика',
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5)),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Period selector
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: List.generate(_periods.length, (i) {
                      final sel = i == _selectedPeriod;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _selectedPeriod = i);
                            _chartCtrl
                              ..reset()
                              ..forward();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: sel ? AppColors.accent : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(_periods[i],
                                style: TextStyle(
                                  color: sel
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                  fontWeight: sel
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  fontSize: 13,
                                )),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 24),

                // Chart card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Шаги',
                                  style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 13)),
                              SizedBox(height: 4),
                              Text('8 742',
                                  style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w800)),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.teal.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.trending_up_rounded,
                                    color: AppColors.teal, size: 16),
                                SizedBox(width: 4),
                                Text('+12%',
                                    style: TextStyle(
                                        color: AppColors.teal,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      AnimatedBuilder(
                        animation: _chartAnim,
                        builder: (_, __) => _BarChart(
                          data: _weekData,
                          labels: _days,
                          progress: _chartAnim.value,
                          highlightIndex: 5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Ring stats
                Row(
                  children: [
                    Expanded(
                        child: _RingCard(
                      label: 'Цель',
                      value: 87,
                      color: AppColors.accent,
                      center: '87%',
                    )),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _RingCard(
                      label: 'Активность',
                      value: 62,
                      color: AppColors.teal,
                      center: '62%',
                    )),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _RingCard(
                      label: 'Сон',
                      value: 75,
                      color: AppColors.coral,
                      center: '7.5h',
                    )),
                  ],
                ),

                const SizedBox(height: 20),

                // Records
                _SectionHeader(title: 'Рекорды'),
                const SizedBox(height: 14),
                ..._records.map((r) => _RecordTile(record: r)),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BarChart extends StatelessWidget {
  final List<int> data;
  final List<String> labels;
  final double progress;
  final int highlightIndex;

  const _BarChart({
    required this.data,
    required this.labels,
    required this.progress,
    required this.highlightIndex,
  });

  @override
  Widget build(BuildContext context) {
    final maxVal = data.reduce(math.max).toDouble();
    return SizedBox(
      height: 140,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(data.length, (i) {
          final ratio = (data[i] / maxVal) * progress;
          final isHigh = i == highlightIndex;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: FractionallySizedBox(
                      alignment: Alignment.bottomCenter,
                      heightFactor: ratio.clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isHigh
                                ? [AppColors.accentSoft, AppColors.accent]
                                : [
                                    AppColors.divider,
                                    AppColors.textSecondary.withOpacity(0.3)
                                  ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(labels[i],
                      style: TextStyle(
                        color: isHigh
                            ? AppColors.accent
                            : AppColors.textSecondary,
                        fontSize: 11,
                        fontWeight:
                            isHigh ? FontWeight.w700 : FontWeight.w400,
                      )),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _RingCard extends StatelessWidget {
  final String label, center;
  final double value;
  final Color color;

  const _RingCard({
    required this.label,
    required this.value,
    required this.color,
    required this.center,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CustomPaint(
              painter: _RingPainter(
                  value: value / 100, color: color),
              child: Center(
                child: Text(center,
                    style: TextStyle(
                        color: color,
                        fontSize: 11,
                        fontWeight: FontWeight.w800)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 11)),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double value;
  final Color color;
  _RingPainter({required this.value, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 5.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final bgPaint = Paint()
      ..color = color.withOpacity(0.15)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * value,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.value != value;
}

class _Record {
  final String title, value, date;
  final IconData icon;
  final Color color;
  const _Record(this.title, this.value, this.date, this.icon, this.color);
}

const _records = [
  _Record('Макс. шагов за день', '14 521', '15 мая',
      Icons.emoji_events_rounded, AppColors.amber),
  _Record('Самая длинная серия', '21 день', '1 июня',
      Icons.local_fire_department_rounded, AppColors.coral),
  _Record('Лучшее время бега', '5:12 / км', '20 мая',
      Icons.speed_rounded, AppColors.teal),
];

class _RecordTile extends StatelessWidget {
  final _Record record;
  const _RecordTile({required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: record.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(record.icon, color: record.color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(record.title,
                style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(record.value,
                  style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 14)),
              Text(record.date,
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700));
  }
}

// ══════════════════════════════════════════════════════════════════
// TAB 4 — PROFILE
// ══════════════════════════════════════════════════════════════════
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: AppColors.bg,
          expandedHeight: 0,
          title: const Text('Профиль',
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5)),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_outlined,
                  color: AppColors.textSecondary),
              onPressed: () {},
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Avatar block
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 88,
                            height: 88,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.accent, AppColors.teal],
                              ),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: const Center(
                              child: Text('А',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontWeight: FontWeight.w800)),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors.teal,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: AppColors.card, width: 2),
                              ),
                              child: const Icon(Icons.check_rounded,
                                  color: Colors.white, size: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text('Алексей Петров',
                          style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      const Text('Premium участник • с января 2024',
                          style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13)),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _ProfileStat('342', 'Тренировки'),
                          _Vline(),
                          _ProfileStat('21', 'Серия'),
                          _Vline(),
                          _ProfileStat('12', 'Достижения'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Achievements
                _SectionHeader(title: 'Достижения'),
                const SizedBox(height: 14),
                _AchievementsRow(),

                const SizedBox(height: 24),

                // Menu items
                _SectionHeader(title: 'Настройки'),
                const SizedBox(height: 14),
                ..._menuItems.map((m) => _MenuTile(item: m)),

                const SizedBox(height: 20),

                // Logout
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.coral.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: AppColors.coral.withOpacity(0.3)),
                  ),
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.logout_rounded,
                        color: AppColors.coral, size: 20),
                    label: const Text('Выйти',
                        style: TextStyle(
                            color: AppColors.coral,
                            fontWeight: FontWeight.w700,
                            fontSize: 15)),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Vline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 32, width: 1, color: AppColors.divider);
  }
}

class _ProfileStat extends StatelessWidget {
  final String value, label;
  const _ProfileStat(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w800)),
        const SizedBox(height: 2),
        Text(label,
            style: const TextStyle(
                color: AppColors.textSecondary, fontSize: 12)),
      ],
    );
  }
}

class _AchievementsRow extends StatelessWidget {
  final _badges = [
    ('🏃', 'Бегун', AppColors.teal),
    ('🔥', 'Серия', AppColors.coral),
    ('⭐', 'Топ', AppColors.amber),
    ('💪', 'Силач', AppColors.accent),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _badges.map((b) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: (b.$3).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: (b.$3).withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Text(b.$1, style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 6),
                Text(b.$2,
                    style: TextStyle(
                        color: b.$3,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _MenuItem {
  final String title, subtitle;
  final IconData icon;
  final Color color;
  const _MenuItem(this.title, this.subtitle, this.icon, this.color);
}

const _menuItems = [
  _MenuItem('Уведомления', 'Настрой оповещения',
      Icons.notifications_outlined, AppColors.accent),
  _MenuItem('Конфиденциальность', 'Данные и приватность',
      Icons.lock_outline_rounded, AppColors.teal),
  _MenuItem('Подписка', 'Premium активна',
      Icons.star_outline_rounded, AppColors.amber),
  _MenuItem('Поддержка', 'Помощь и FAQ',
      Icons.help_outline_rounded, AppColors.textSecondary),
];

class _MenuTile extends StatelessWidget {
  final _MenuItem item;
  const _MenuTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: item.color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title,
                    style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
                Text(item.subtitle,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded,
              color: AppColors.textSecondary, size: 20),
        ],
      ),
    );
  }
}
