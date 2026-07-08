import 'package:flutter/material.dart';

void main() => runApp(const CampusCafeApp());

class CampusCafeApp extends StatelessWidget {
  const CampusCafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Cafe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B5D4A),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const OrderPage(),
    );
  }
}

class MenuItem {
  final String name;
  final String category;
  final double price;

  const MenuItem(this.name, this.category, this.price);
}

const menu = [
  MenuItem('Jollof Rice & Chicken', 'Main meal', 35.00),
  MenuItem('Waakye Special', 'Main meal', 30.00),
  MenuItem('Banku & Tilapia', 'Main meal', 45.00),
  MenuItem('Meat Pie', 'Snack', 12.00),
  MenuItem('Sobolo 500 ml', 'Drink', 8.00),
  MenuItem('Pineapple Juice', 'Drink', 10.00),
];

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final Map<int, int> _qty = {};
  late final TextEditingController _searchController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    debugPrint('OrderPage: initState() runs once');
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() => _query = _searchController.text.trim().toLowerCase());
    });
  }

  @override
  void dispose() {
    debugPrint('OrderPage: dispose() cleaning up controller');
    _searchController.dispose();
    super.dispose();
  }

  double get _total {
    var sum = 0.0;
    _qty.forEach((i, q) => sum += menu[i].price * q);
    return sum;
  }

  int get _itemCount => _qty.values.fold(0, (sum, q) => sum + q);

  List<int> get _visibleIndexes {
    if (_query.isEmpty) {
      return List.generate(menu.length, (index) => index);
    }
    return [
      for (var i = 0; i < menu.length; i++)
        if (menu[i].name.toLowerCase().contains(_query) ||
            menu[i].category.toLowerCase().contains(_query))
          i,
    ];
  }

  void _change(int index, int delta) {
    setState(() {
      final next = (_qty[index] ?? 0) + delta;
      if (next <= 0) {
        _qty.remove(index);
      } else {
        _qty[index] = next;
      }
    });
  }

  Future<void> _clearOrder() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear order?'),
        content: const Text('All quantities will reset to zero.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(_qty.clear);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Order cleared')));
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('OrderPage: build() drawing UI');
    final visibleIndexes = _visibleIndexes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Cafe'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Badge.count(
              count: _itemCount,
              isLabelVisible: _itemCount > 0,
              child: IconButton(
                tooltip: 'Clear order',
                icon: const Icon(Icons.delete_sweep_outlined),
                onPressed: _qty.isEmpty ? null : _clearOrder,
              ),
            ),
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
                labelText: 'Search menu',
                suffixIcon: _query.isEmpty
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
            child: visibleIndexes.isEmpty
                ? const Center(child: Text('No matching menu items'))
                : ListView.separated(
                    padding: const EdgeInsets.only(bottom: 12),
                    itemCount: visibleIndexes.length,
                    separatorBuilder: (_, separatorIndex) =>
                        const Divider(height: 1),
                    itemBuilder: (context, visibleIndex) {
                      final i = visibleIndexes[visibleIndex];
                      final item = menu[i];
                      final q = _qty[i] ?? 0;

                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(item.name.characters.first),
                        ),
                        title: Text(item.name),
                        subtitle: Text(
                          '${item.category} | GHS ${item.price.toStringAsFixed(2)}',
                        ),
                        trailing: QuantityStepper(
                          quantity: q,
                          onDecrease: q == 0 ? null : () => _change(i, -1),
                          onIncrease: () => _change(i, 1),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_itemCount items',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'GHS ${_total.toStringAsFixed(2)}',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// This widget is stateless because the parent owns the changing quantity state.
class QuantityStepper extends StatelessWidget {
  final int quantity;
  final VoidCallback? onDecrease;
  final VoidCallback onIncrease;

  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Remove one',
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: onDecrease,
        ),
        SizedBox(
          width: 32,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          tooltip: 'Add one',
          icon: const Icon(Icons.add_circle_outline),
          onPressed: onIncrease,
        ),
      ],
    );
  }
}
