import 'package:compiladores_tarea1/services/traslate_services.dart';
import 'package:flutter/material.dart';
import 'package:compiladores_tarea1/utils/languaje_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LANGUAGE TRANSLATOR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TranslateScreen(),
    );
  }
}

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TranslateScreenState createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final TextEditingController _textController = TextEditingController();
  String _translatedText = '';
  String _selectedLanguage = 'pt'; // Default language code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translate'),
      ),
      body: Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _textController,
                decoration:
                    const InputDecoration(labelText: 'Enter text to translate'),
              ),
              const SizedBox(height: 30),
              DropdownButtonFormField<String>(
                value: _selectedLanguage,
                onChanged: (newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                  });
                },
                items: languageMap.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.value,
                    child: Text(entry.key),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  final text = _textController.text;
                  translateText(text, _selectedLanguage).then((result) {
                    setState(() {
                      _translatedText = result;
                    });
                  }).catchError((error) {
                    print('Error en la traducción: $error');
                  });
                },
                child: const Text('Translate'),
              ),
              const SizedBox(height: 30),
              const Text(
                'Translated Text:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                _translatedText,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
