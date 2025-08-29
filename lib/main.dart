import 'package:flutter/material.dart';

// Entry point of the app
void main() => runApp(const UnitConverterApp());

// Main app widget
class UnitConverterApp extends StatelessWidget {
  const UnitConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      debugShowCheckedModeBanner: false,
      // App theme settings
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF00B4D8), // bright ocean blue
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF00B4D8),    // main ocean blue
          secondary: const Color(0xFF90E0EF),  // light aqua
          surface: Colors.grey[100]!,
        ),
        scaffoldBackgroundColor: const Color(0xFFE0F7FA), // very light aqua
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00B4D8),
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF00B4D8),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF00B4D8)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        // Card theme for info/result cards
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      home: const ConverterScreen(), // Main screen
    );
  }
}

// Main converter screen (stateful)
class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _inputCtrl = TextEditingController();

  // Supported categories
  final List<String> _categories = ['Distance', 'Weight'];

  // Conversion factors relative to a base unit for each category
  // Distance base = metre (m); Weight base = gram (g)
  final Map<String, Map<String, double>> _factors = {
    'Distance': {
      'km': 1000.0,        // 1 km = 1000 m
      'miles': 1609.344,   // 1 mile = 1609.344 m
      'metres': 1.0,       // base
      'cm': 0.01,          // 1 cm = 0.01 m
    },
    'Weight': {
      'kg': 1000.0,        // 1 kg = 1000 g
      'lb': 453.59237,     // 1 lb = 453.59237 g
      'gm': 1.0,           // base (gram)
    },
  };

  String _selectedCategory = 'Distance'; // Current category
  String _fromUnit = 'km';               // Unit to convert from
  String _toUnit = 'miles';              // Unit to convert to
  String _result = '';                   // Result string

  // Get available units for the selected category
  List<String> get _unitsForCategory =>
      _factors[_selectedCategory]!.keys.toList();

  @override
  void initState() {
    super.initState();
    _syncUnitsWithCategory(); // Initialize units for default category
  }

  // Sync units when category changes
  void _syncUnitsWithCategory() {
    final units = _unitsForCategory;
    _fromUnit = units.first;
    _toUnit = units.length > 1 ? units[1] : units.first;
    setState(() {});
  }

  // Swap the "from" and "to" units
  void _swapUnits() {
    setState(() {
      final tmp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = tmp;
    });
    _convert(); // Recalculate after swap
  }

  // Perform the conversion and update result
  void _convert() {
    final raw = _inputCtrl.text.trim();
    if (raw.isEmpty) {
      setState(() => _result = 'Please enter a value.');
      return;
    }

    final value = double.tryParse(raw);
    if (value == null) {
      setState(() => _result = 'Enter a valid number (e.g., 12.5).');
      return;
    }

    final factors = _factors[_selectedCategory]!;
    final fromFactor = factors[_fromUnit]!;
    final toFactor = factors[_toUnit]!;

    // Convert input to base unit, then to target unit
    final valueInBase = value * fromFactor;
    final converted = valueInBase / toFactor;

    setState(() {
      _result = '$value $_fromUnit = ${_formatNumber(converted)} $_toUnit';
    });
  }

  // Format number for display (handles large/small numbers)
  String _formatNumber(double n) {
    if (n == 0) return '0';
    final absN = n.abs();
    if (absN >= 1000000 || absN < 0.0001) {
      return n.toStringAsExponential(4);
    }
    final str = n.toStringAsFixed(6);
    return str.replaceFirst(RegExp(r'\.?0+$'), '');
  }

  @override
  Widget build(BuildContext context) {
    final units = _unitsForCategory;

    return Scaffold(
      appBar: AppBar(title: const Text('Unit Converter')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Info card with gradient background
          Card(
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF90E0EF), Color(0xFF00B4D8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Convert between Metric and Imperial units.\n'
                'Distance: km ⇄ miles, km ⇄ metres, cm ⇄ metres.\n'
                'Weight: kg ⇄ lb, gm ⇄ kg, kg ⇄ gm.',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Category dropdown
          _Labeled(
            label: 'Measure',
            child: DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: _categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) {
                if (v == null) return;
                setState(() => _selectedCategory = v);
                _syncUnitsWithCategory();
              },
            ),
          ),
          const SizedBox(height: 12),

          // Row for "from" and "to" unit dropdowns and swap button
          Row(
            children: [
              Expanded(
                child: _Labeled(
                  label: 'From',
                  child: DropdownButtonFormField<String>(
                    value: _fromUnit,
                    items: units
                        .map((u) =>
                            DropdownMenuItem(value: u, child: Text(u)))
                        .toList(),
                    onChanged: (v) => setState(() => _fromUnit = v ?? _fromUnit),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Swap units button
              IconButton.filledTonal(
                onPressed: _swapUnits,
                icon: const Icon(Icons.swap_horiz),
                tooltip: 'Swap',
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _Labeled(
                  label: 'To',
                  child: DropdownButtonFormField<String>(
                    value: _toUnit,
                    items: units
                        .map((u) =>
                            DropdownMenuItem(value: u, child: Text(u)))
                        .toList(),
                    onChanged: (v) => setState(() => _toUnit = v ?? _toUnit),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Input field for value to convert
          _Labeled(
            label: 'Value',
            child: TextField(
              controller: _inputCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                hintText: 'Enter a number (e.g., 12.5)',
              ),
              onSubmitted: (_) => _convert(),
            ),
          ),
          const SizedBox(height: 16),

          // Convert button
          SizedBox(
            height: 48,
            child: FilledButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
          ),
          const SizedBox(height: 20),

          // Result card (shown only if result is not empty)
          if (_result.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _result,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Helper widget for labeled form fields
class _Labeled extends StatelessWidget {
  final String label;
  final Widget child;
  const _Labeled({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            )),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}
