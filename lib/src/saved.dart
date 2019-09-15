import "package:flutter/material.dart";
import 'package:english_words/english_words.dart';

class SavedListView extends StatefulWidget {
  SavedListView({@required this.saved});
  final Set<WordPair> saved;
  @override
  State<StatefulWidget> createState() => _SavedListView(saved: saved);
}

class _SavedListView extends State<SavedListView> {
  _SavedListView({@required this.saved});

  final Set<WordPair> saved;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("좋아하는거")),
      body: this._buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: this.saved.length * 2,
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider();
          }
          var realIndex = index ~/ 2;
          return this._buildRow(this.saved.toList()[realIndex]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.toString(),
        textScaleFactor: 2,
      ),
      onTap: () {
        setState(() {
          this.saved.remove(pair);
        });
      },
    );
  }
}
