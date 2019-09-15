import "package:flutter/material.dart";
import 'package:english_words/english_words.dart';
import 'package:app/src/saved.dart';

class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _wordList = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("내용"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SavedListView(saved: this._saved)));
              },
            )
          ],
        ),
        body: this._buildList());
  }

  Widget _buildList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        /**
           * flutter listview 에서는 밑에있는 선 / 구분자도 index 로 들어감
           * 따라서 그걸로 isOdd일 경우 그냥 선으로 만들어 주기 위해서 Divider 을 사용해준다
           */
        if (index.isOdd) {
          return Divider();
        }
        var realIndex = index ~/ 2;
        if (realIndex >= _wordList.length) {
          _wordList.addAll(generateWordPairs().take(10));
        }
        return this._wordRow(_wordList[realIndex]);
      },
    );
  }

  Widget _wordRow(WordPair pair) {
    final bool iLoveIt = this._saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asCamelCase,
        textScaleFactor: 2,
      ),
      trailing: Icon(iLoveIt ? Icons.favorite : Icons.favorite_border,
          color: Colors.pink),
      onTap: () {
        setState(() {
          if (iLoveIt) {
            this._saved.remove(pair);
          } else {
            this._saved.add(pair);
          }
        });
      },
    );
  }
}
