import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

void main() {
  runApp(const AnagramSolverApp());
}

class AnagramSolverApp extends StatelessWidget {
  const AnagramSolverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anagram Solver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnagramSolverHomePage(),
    );
  }
}

class AnagramSolverHomePage extends StatefulWidget {
  const AnagramSolverHomePage({super.key});

  @override
  AnagramSolverHomePageState createState() => AnagramSolverHomePageState();
}

class AnagramSolverHomePageState extends State<AnagramSolverHomePage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _solutions = [];
  List<String> _dictionary = [];

  @override
  void initState() {
    super.initState();
    _loadDictionary();
  }

  Future<void> _loadDictionary() async {
    final String response = await rootBundle.loadString('assets/words.txt');
    setState(() {
      _dictionary = const LineSplitter().convert(response);
    });
  }

  void _findAnagrams(String letters) {
    if (letters.isEmpty) {
      setState(() {
        _solutions = [];
      });
      return;
    }

    final inputLetters = letters.split('')..sort();
    final validWords = _dictionary.where((word) {
      if (word.length < 3 || word.length > letters.length) {
        return false;
      }
      final wordLetters = word.split('')..sort();
      return _isSubset(inputLetters, wordLetters);
    }).toList();

    validWords.sort((a, b) {
      if (a.length == b.length) {
        return a.compareTo(b);
      }
      return b.length.compareTo(a.length);
    });

    setState(() {
      _solutions = validWords;
    });
  }

  bool _isSubset(List<String> big, List<String> small) {
    var bigCopy = List.from(big);
    for (var letter in small) {
      if (!bigCopy.remove(letter)) {
        return false;
      }
    }
    return true;
  }

  int _calculatePoints(String word) {
    switch (word.length) {
      case 3:
        return 100;
      case 4:
        return 400;
      case 5:
        return 1200;
      case 6:
        return 2000;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Anagram Solver',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter letters',
                border: OutlineInputBorder(),
              ),
              onChanged: _findAnagrams,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _solutions.length,
                itemBuilder: (context, index) {
                  final word = _solutions[index];
                  final points = _calculatePoints(word);
                  return ListTile(
                    title: RichText(
                      text: TextSpan(
                        text: word,
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: ' ($points)',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
