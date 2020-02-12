import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State createState() {
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  final _wordPairs = <WordPair>[];
  final _font = const TextStyle(fontSize: 18.0);

  // Build list view
  ListView _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),

        itemBuilder: (context, i) {
          if (i.isOdd)
            return new Divider();

          // Find index of current word pair
          int wordPairIndex = (i / 2).toInt();

          // If need to generate new words
          if (wordPairIndex >= _wordPairs.length)
            generateNewWordPairs();

          // Find current word pair and build list row from it
          WordPair wordPair = _wordPairs[wordPairIndex];
          ListTile row = _buildListRowFromWordPair(wordPair);
          return row;
        });
  }

  // Convert one word pair to a list row
  ListTile _buildListRowFromWordPair(WordPair pair) {
    return _buildListRowFromString(pair.asPascalCase);
  }

  // Convert text to a list row
  ListTile _buildListRowFromString(String text) {
    return ListTile(
      title: Text(
        text,
        style: _font,
      ),
    );
  }

  // Add new random words to the list
  void generateNewWordPairs() {
    _wordPairs.addAll(generateWordPairs().take(10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Name Infinite List"),
      ),

      body: _buildList(),
    );

    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }
}