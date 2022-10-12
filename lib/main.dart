import 'package:flutter/material.dart';
import 'dart:math';

Map<String, String> english = {
  "spread": "diffuser"
};

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Révisions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Révisions"),
      ),
      body: Center(
        child: AskPane(words: english),
      ),
    );
  }
}

class AskPane extends StatefulWidget {
  const AskPane({required this.words, super.key});

  final Map<String, String> words;

  @override
  State<StatefulWidget> createState() {
    return _AskPaneState();
  }
}

class _AskPaneState extends State<AskPane> {
  final Random random = Random();
  String word = "";
  String translation = "";
  String info = "";
  bool validate = false;
  String field = "";

  void generateWord() {
    int index = random.nextInt(widget.words.length);
    bool a = random.nextBool();

    String key = widget.words.entries.elementAt(index).key;
    String value = widget.words.entries.elementAt(index).value;

    word = a ? key : value;
    translation = a ? value : key;
  }

  @override
  Widget build(BuildContext context) {
    if (word.isEmpty || translation.isEmpty) {
      setState(() {
        generateWord();
      });
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            word,
            textAlign: TextAlign.center,
          ),
          TextField(
            onChanged: (value) {
              field = value;
            },
          ),
          Text(info,
            textAlign: TextAlign.center,
          ),
          TextButton(
              onPressed: () {
                if (validate) {
                  setState(() {
                    generateWord();
                    validate = false;
                  });
                } else {
                  if (field.toLowerCase() == translation.toLowerCase()) {
                    validate = true;
                    info = "Bravo!";
                  } else {
                    setState(() {
                      validate = true;
                      info = "La réponse était: $translation.";
                    });
                  }
                }
              },
              child: Text(validate ? "Continuer" : "Valider"))
        ],
      )
    );
  }
}