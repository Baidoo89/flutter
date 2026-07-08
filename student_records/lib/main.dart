import 'package:flutter/material.dart';

import 'database_helper.dart';
import 'student.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  runApp(const RecordsApp());
}

class RecordsApp extends StatelessWidget {
  const RecordsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Records',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2556A3)),
        useMaterial3: true,
      ),
      home: const StudentListPage(),
    );
  }
}

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final _dbh = DatabaseHelper.instance;
  final _searchController = TextEditingController();
  List<Student> _students = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _refresh();
    _searchController.addListener(_refresh);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    final data = await _dbh.searchStudents(_searchController.text);
    if (!mounted) return;
    setState(() {
      _students = data;
      _loading = false;
    });
  }

  Future<void> _openForm({Student? existing}) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => StudentFormSheet(existing: existing),
    );

    if (saved == true) {
      await _refresh();
    }
  }

  Future<void> _confirmDelete(Student student) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete ${student.fullName}?'),
        content: const Text(
          'This record will be removed from the local database.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (ok == true) {
      await _dbh.deleteStudent(student.id!);
      await _refresh();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Student deleted')));
      }
    }
  }

  Future<void> _showStats() async {
    final stats = await _dbh.levelCounts();
    if (!mounted) return;

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Class statistics'),
        content: stats.isEmpty
            ? const Text('No records yet.')
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final entry in stats.entries)
                    ListTile(
                      leading: const Icon(Icons.analytics_outlined),
                      title: Text('Level ${entry.key}'),
                      trailing: Text('${entry.value}'),
                    ),
                ],
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Records'),
        actions: [
          IconButton(
            tooltip: 'Statistics',
            onPressed: _showStats,
            icon: const Icon(Icons.bar_chart_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: 'Search students',
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Clear search',
                        icon: const Icon(Icons.close),
                        onPressed: _searchController.clear,
                      ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _students.isEmpty
                ? const Center(
                    child: Text('No students found. Tap + to add one.'),
                  )
                : ListView.separated(
                    itemCount: _students.length,
                    separatorBuilder: (_, separatorIndex) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final student = _students[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text('${student.level ~/ 100}'),
                        ),
                        title: Text(student.fullName),
                        subtitle: Text(
                          '${student.indexNo} | ${student.programme}\n${student.email}',
                        ),
                        isThreeLine: student.email.isNotEmpty,
                        onTap: () => _openForm(existing: student),
                        onLongPress: () => _confirmDelete(student),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }
}

class StudentFormSheet extends StatefulWidget {
  final Student? existing;

  const StudentFormSheet({super.key, this.existing});

  @override
  State<StudentFormSheet> createState() => _StudentFormSheetState();
}

class _StudentFormSheetState extends State<StudentFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _dbh = DatabaseHelper.instance;
  late final TextEditingController _indexCtrl;
  late final TextEditingController _nameCtrl;
  late final TextEditingController _programmeCtrl;
  late final TextEditingController _levelCtrl;
  late final TextEditingController _emailCtrl;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _indexCtrl = TextEditingController(text: existing?.indexNo ?? '');
    _nameCtrl = TextEditingController(text: existing?.fullName ?? '');
    _programmeCtrl = TextEditingController(
      text: existing?.programme ?? 'BSc Computer Science',
    );
    _levelCtrl = TextEditingController(
      text: existing?.level.toString() ?? '100',
    );
    _emailCtrl = TextEditingController(text: existing?.email ?? '');
  }

  @override
  void dispose() {
    _indexCtrl.dispose();
    _nameCtrl.dispose();
    _programmeCtrl.dispose();
    _levelCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    final student = Student(
      id: widget.existing?.id,
      indexNo: _indexCtrl.text.trim(),
      fullName: _nameCtrl.text.trim(),
      programme: _programmeCtrl.text.trim(),
      level: int.parse(_levelCtrl.text.trim()),
      email: _emailCtrl.text.trim(),
    );

    if (widget.existing == null) {
      await _dbh.insertStudent(student);
    } else {
      await _dbh.updateStudent(student);
    }

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existing != null;
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isEditing ? 'Edit student' : 'Add student',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _indexCtrl,
                decoration: const InputDecoration(labelText: 'Index number'),
                validator: _required,
              ),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: _required,
              ),
              TextFormField(
                controller: _programmeCtrl,
                decoration: const InputDecoration(labelText: 'Programme'),
                validator: _required,
              ),
              TextFormField(
                controller: _levelCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Level'),
                validator: (value) {
                  final level = int.tryParse(value ?? '');
                  if (level == null) return 'Enter a number';
                  if (level < 100 || level > 600) return 'Use a valid level';
                  return null;
                },
              ),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _saving ? null : _save,
                icon: _saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save_outlined),
                label: Text(isEditing ? 'Update' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
