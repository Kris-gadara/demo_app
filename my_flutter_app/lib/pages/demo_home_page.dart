import 'package:flutter/material.dart';
import 'dart:math';

// ─── Task Model ──────────────────────────────────────────────────────────────
class Task {
  final String id;
  String title;
  bool completed;
  final DateTime createdAt;
  final TaskCategory category;

  Task({
    required this.id,
    required this.title,
    this.completed = false,
    this.category = TaskCategory.personal,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

enum TaskCategory {
  personal(Icons.person, Color(0xFF6C63FF), 'Personal'),
  work(Icons.work, Color(0xFFFF6B6B), 'Work'),
  shopping(Icons.shopping_cart, Color(0xFF4ECDC4), 'Shopping'),
  health(Icons.favorite, Color(0xFFFFBE0B), 'Health');

  final IconData icon;
  final Color color;
  final String label;
  const TaskCategory(this.icon, this.color, this.label);
}

// ─── Main Page ───────────────────────────────────────────────────────────────
class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage>
    with TickerProviderStateMixin {
  final TextEditingController _taskController = TextEditingController();
  final List<Task> _tasks = [];
  TaskCategory _selectedCategory = TaskCategory.personal;
  int _currentNavIndex = 0;
  late AnimationController _fabController;

  // Sample tasks for first launch
  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    // Add sample tasks so the app doesn't look empty
    _tasks.addAll([
      Task(
        id: '1',
        title: 'Complete Flutter project setup',
        completed: true,
        category: TaskCategory.work,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Task(
        id: '2',
        title: 'Design app UI mockups',
        category: TaskCategory.work,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      Task(
        id: '3',
        title: 'Buy groceries for the week',
        category: TaskCategory.shopping,
      ),
      Task(
        id: '4',
        title: 'Morning jog — 5km',
        completed: true,
        category: TaskCategory.health,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      Task(
        id: '5',
        title: 'Read 20 pages of Flutter docs',
        category: TaskCategory.personal,
      ),
    ]);
  }

  @override
  void dispose() {
    _taskController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  // ─── Task Operations ────────────────────────────────────────────────────
  void _addTask(String taskTitle) {
    if (taskTitle.trim().isEmpty) return;
    setState(() {
      _tasks.insert(
        0,
        Task(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: taskTitle.trim(),
          category: _selectedCategory,
        ),
      );
    });
    _taskController.clear();
    Navigator.of(context).pop();
  }

  void _toggleTask(String taskId) {
    setState(() {
      final idx = _tasks.indexWhere((t) => t.id == taskId);
      if (idx != -1) _tasks[idx].completed = !_tasks[idx].completed;
    });
  }

  void _deleteTask(String taskId) {
    setState(() => _tasks.removeWhere((t) => t.id == taskId));
  }

  // ─── Computed Stats ──────────────────────────────────────────────────────
  int get _completedCount => _tasks.where((t) => t.completed).length;
  int get _pendingCount => _tasks.where((t) => !t.completed).length;
  double get _progressPercent =>
      _tasks.isEmpty ? 0 : _completedCount / _tasks.length;

  // ─── Build ───────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: IndexedStack(
        index: _currentNavIndex,
        children: [
          _buildDashboard(theme),
          _buildAllTasks(theme),
          _buildProfilePage(theme),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTaskSheet,
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Task', style: TextStyle(fontWeight: FontWeight.w600)),
        elevation: 4,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DASHBOARD TAB
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDashboard(ThemeData theme) {
    return CustomScrollView(
      slivers: [
        // ── Gradient Header ──────────────────────────────────────────────
        SliverToBoxAdapter(child: _buildHeader()),
        // ── Stats Cards ──────────────────────────────────────────────────
        SliverToBoxAdapter(child: _buildStatsRow()),
        // ── Category Chips ───────────────────────────────────────────────
        SliverToBoxAdapter(child: _buildCategorySection()),
        // ── Recent Tasks ─────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
            child: Text('Recent Tasks',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
        ),
        _tasks.isEmpty
            ? SliverToBoxAdapter(child: _buildEmptyState())
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => _buildTaskCard(_tasks[i]),
                  childCount: min(_tasks.length, 5),
                ),
              ),
        const SliverToBoxAdapter(child: SizedBox(height: 90)),
      ],
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
        bottom: 24,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6C63FF), Color(0xFF3B3486)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_greeting(),
                      style: TextStyle(
                          color: Colors.white.withAlpha(180), fontSize: 14)),
                  const SizedBox(height: 4),
                  const Text('TaskFlow',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              // Avatar
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const CircleAvatar(
                  radius: 22,
                  backgroundColor: Color(0xFF9B92FF),
                  child: Icon(Icons.person, color: Colors.white, size: 24),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Progress bar
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today\'s Progress',
                      style: TextStyle(
                          color: Colors.white.withAlpha(200), fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: _progressPercent,
                        backgroundColor: Colors.white.withAlpha(50),
                        color: const Color(0xFF4ECDC4),
                        minHeight: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${(_progressPercent * 100).toInt()}%',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good Morning 👋';
    if (h < 17) return 'Good Afternoon ☀️';
    return 'Good Evening 🌙';
  }

  // ── Stats Row ──────────────────────────────────────────────────────────
  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          _statCard('Total', _tasks.length, const Color(0xFF6C63FF),
              Icons.list_alt_rounded),
          const SizedBox(width: 12),
          _statCard('Done', _completedCount, const Color(0xFF4ECDC4),
              Icons.check_circle_outline_rounded),
          const SizedBox(width: 12),
          _statCard('Pending', _pendingCount, const Color(0xFFFF6B6B),
              Icons.pending_actions_rounded),
        ],
      ),
    );
  }

  Widget _statCard(String label, int count, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: color.withAlpha(40),
                blurRadius: 12,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text('$count',
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 2),
            Text(label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  // ── Category Section ───────────────────────────────────────────────────
  Widget _buildCategorySection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Categories',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: TaskCategory.values.map((cat) {
              final count = _tasks.where((t) => t.category == cat).length;
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                  decoration: BoxDecoration(
                    color: cat.color.withAlpha(25),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: cat.color.withAlpha(80)),
                  ),
                  child: Column(
                    children: [
                      Icon(cat.icon, color: cat.color, size: 22),
                      const SizedBox(height: 6),
                      Text(cat.label,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: cat.color)),
                      Text('$count',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: cat.color)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ── Task Card ──────────────────────────────────────────────────────────
  Widget _buildTaskCard(Task task) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Dismissible(
        key: Key(task.id),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => _deleteTask(task.id),
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 24),
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: Colors.red.shade400,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withAlpha(12),
                  blurRadius: 8,
                  offset: const Offset(0, 2)),
            ],
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            leading: GestureDetector(
              onTap: () => _toggleTask(task.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: task.completed
                      ? task.category.color
                      : Colors.transparent,
                  border: Border.all(
                    color: task.category.color,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: task.completed
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : null,
              ),
            ),
            title: Text(
              task.title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                decoration:
                    task.completed ? TextDecoration.lineThrough : null,
                color: task.completed ? Colors.grey : Colors.black87,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Icon(task.category.icon,
                      size: 14, color: task.category.color),
                  const SizedBox(width: 4),
                  Text(task.category.label,
                      style: TextStyle(
                          fontSize: 12, color: task.category.color)),
                  const SizedBox(width: 8),
                  Text(_timeAgo(task.createdAt),
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                ],
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete_outline,
                  color: Colors.grey.shade400, size: 20),
              onPressed: () => _deleteTask(task.id),
            ),
          ),
        ),
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  // ── Empty State ────────────────────────────────────────────────────────
  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(Icons.task_alt_rounded, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text('No tasks yet!',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500)),
          const SizedBox(height: 8),
          Text('Tap + to add your first task',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade400)),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ALL TASKS TAB
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildAllTasks(ThemeData theme) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Text('All Tasks',
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
          // Filter chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _filterChip('All', null),
                ...TaskCategory.values.map((c) => _filterChip(c.label, c)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _tasks.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 90),
                    itemCount: _tasks.length,
                    itemBuilder: (ctx, i) => _buildTaskCard(_tasks[i]),
                  ),
          ),
        ],
      ),
    );
  }

  TaskCategory? _filterCategory;
  Widget _filterChip(String label, TaskCategory? category) {
    final isSelected = _filterCategory == category;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        selected: isSelected,
        label: Text(label, style: const TextStyle(fontSize: 13)),
        selectedColor: const Color(0xFF6C63FF).withAlpha(40),
        checkmarkColor: const Color(0xFF6C63FF),
        onSelected: (_) => setState(() => _filterCategory = category),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PROFILE TAB
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildProfilePage(ThemeData theme) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Avatar
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF6C63FF),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text('Guest User',
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('Demo Mode',
                  style: TextStyle(
                      color: Colors.orange.shade800,
                      fontWeight: FontWeight.w600,
                      fontSize: 12)),
            ),
            const SizedBox(height: 32),
            // Stats
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(12),
                      blurRadius: 10,
                      offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                children: [
                  _profileStat(
                      'Tasks Created', '${_tasks.length}', Icons.list_alt),
                  const Divider(),
                  _profileStat(
                      'Completed', '$_completedCount', Icons.check_circle),
                  const Divider(),
                  _profileStat(
                      'Pending', '$_pendingCount', Icons.pending_actions),
                  const Divider(),
                  _profileStat(
                    'Completion Rate',
                    '${(_progressPercent * 100).toInt()}%',
                    Icons.analytics,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Info card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF).withAlpha(15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: const Color(0xFF6C63FF).withAlpha(50)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline,
                          color: Color(0xFF6C63FF), size: 20),
                      SizedBox(width: 8),
                      Text('Demo Mode Info',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C63FF))),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tasks are stored locally and will be lost on app restart. '
                    'To enable cloud sync, configure Firebase in '
                    'lib/firebase_options.dart.',
                    style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileStat(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6C63FF), size: 22),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 15)),
          const Spacer(),
          Text(value,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C63FF))),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ADD TASK BOTTOM SHEET
  // ═══════════════════════════════════════════════════════════════════════════
  void _showAddTaskSheet() {
    _selectedCategory = TaskCategory.personal;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              top: 20,
              left: 20,
              right: 20,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('New Task',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(
                  controller: _taskController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'What do you need to do?',
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.edit_note_rounded),
                  ),
                  onSubmitted: _addTask,
                ),
                const SizedBox(height: 16),
                const Text('Category',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: TaskCategory.values.map((cat) {
                    final isSelected = _selectedCategory == cat;
                    return ChoiceChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(cat.icon,
                              size: 16,
                              color: isSelected ? Colors.white : cat.color),
                          const SizedBox(width: 4),
                          Text(cat.label),
                        ],
                      ),
                      selected: isSelected,
                      selectedColor: cat.color,
                      labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontSize: 13),
                      onSelected: (_) {
                        setSheetState(() => _selectedCategory = cat);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _addTask(_taskController.text),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                    child: const Text('Add Task',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BOTTOM NAV
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBottomNav() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.white,
      elevation: 12,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(0, Icons.dashboard_rounded, 'Home'),
            _navItem(1, Icons.checklist_rounded, 'Tasks'),
            const SizedBox(width: 48), // FAB spacing
            _navItem(2, Icons.person_rounded, 'Profile'),
            _navItem(-1, Icons.info_outline_rounded, 'About',
                onTap: _showAbout),
          ],
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label,
      {VoidCallback? onTap}) {
    final isActive = _currentNavIndex == index && onTap == null;
    return InkWell(
      onTap: onTap ?? () => setState(() => _currentNavIndex = index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                color: isActive ? const Color(0xFF6C63FF) : Colors.grey,
                size: 24),
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    color: isActive ? const Color(0xFF6C63FF) : Colors.grey,
                    fontWeight:
                        isActive ? FontWeight.w600 : FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  void _showAbout() {
    showAboutDialog(
      context: context,
      applicationName: 'TaskFlow',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFF6C63FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.task_alt, color: Colors.white, size: 28),
      ),
      children: [
        const Text(
          'A beautiful task management app built with Flutter.\n\n'
          'Features:\n• Create & manage tasks\n• Categorize tasks\n'
          '• Track progress\n• Firebase integration (optional)',
        ),
      ],
    );
  }
}


