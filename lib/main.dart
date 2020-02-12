import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: RandomWords(),
      theme: ThemeData(
        primaryColor: Colors.white
      ),

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
  final Set<WordPair> _saved = Set<WordPair>();

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
    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _font,
      ),

      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : Colors.grey,
      ),

      onTap: () {
        setState(() {
          if (alreadySaved)
            _saved.remove(pair);
          else
            _saved.add(pair);
        });
      },
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

        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.list),
            onPressed: _clickSaved,
          )
        ],
      ),

      body: _buildList(),
    );

    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }

  void _clickSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _font,
                ),
              );
            },
          );

          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text("Saved Words"),
            ),

            body: ListView(
              children: divided,
            ),
          );
        }
      )
    );
  }
}