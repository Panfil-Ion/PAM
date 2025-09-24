import 'package:flutter/material.dart';

void main() {
  runApp(const CaloriiApp());
}

class CaloriiApp extends StatelessWidget {
  const CaloriiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Calorii',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const CaloriiHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Aliment {
  final String nume;
  final double calorii;

  Aliment({required this.nume, required this.calorii});
}

class CaloriiHomePage extends StatefulWidget {
  const CaloriiHomePage({super.key});

  @override
  State<CaloriiHomePage> createState() => _CaloriiHomePageState();
}

class _CaloriiHomePageState extends State<CaloriiHomePage> {
  final _numeController = TextEditingController();
  final _caloriiController = TextEditingController();

  final List<Aliment> _alimente = [];

  double get _totalCalorii {
    return _alimente.fold(0.0, (sum, item) => sum + item.calorii);
  }

  @override
  void dispose() {
    _numeController.dispose();
    _caloriiController.dispose();
    super.dispose();
  }

  void _adaugaAliment() {
    final nume = _numeController.text.trim();
    final caloriiText = _caloriiController.text.trim();

    if (nume.isEmpty || caloriiText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completează ambele câmpuri.')),
      );
      return;
    }

    final cal = double.tryParse(caloriiText.replaceAll(',', '.'));
    if (cal == null || cal <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Introdu un număr valid (> 0) la calorii.')),
      );
      return;
    }

    setState(() {
      _alimente.add(Aliment(nume: nume, calorii: cal));
      _numeController.clear();
      _caloriiController.clear();
    });
  }

  void _stergeAliment(int index) {
    setState(() {
      _alimente.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator Calorii'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _alimente.isEmpty
                ? null
                : () {
              setState(() {
                _alimente.clear();
              });
            },
            tooltip: 'Șterge toate',
          ),
        ],
      ),
      body: Padding(//115,75,,164,,45
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input fields
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _numeController,
                    decoration: const InputDecoration(
                      labelText: 'Aliment',
                      hintText: 'ex: Măr',
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _caloriiController,
                    decoration: const InputDecoration(
                      labelText: 'Calorii',
                      hintText: 'ex: 95',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onSubmitted: (_) => _adaugaAliment(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Buton Adaugă
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _adaugaAliment,
                icon: const Icon(Icons.add),
                label: const Text('Adaugă'),
              ),
            ),

            const SizedBox(height: 16),

            // Lista alimentelor
            Expanded(
              child: _alimente.isEmpty
                  ? const Center(
                child: Text(
                  'Niciun aliment adăugat.',
                  style: TextStyle(color: Colors.black54),
                ),
              )
                  : ListView.builder(
                itemCount: _alimente.length,
                itemBuilder: (context, index) {
                  final aliment = _alimente[index];
                  return Dismissible(
                    key: ValueKey('${aliment.nume}-$index'),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 16),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) => _stergeAliment(index),
                    child: ListTile(
                      title: Text(aliment.nume),
                      trailing: Text('${aliment.calorii} kcal'),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Total calorii
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Text(
                    'Total zilnic:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    '${_totalCalorii.toStringAsFixed(1)} kcal',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}