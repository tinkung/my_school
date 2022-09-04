import 'package:flutter/material.dart';
import 'package:my_school/connect.dart';
import 'package:mysql1/mysql1.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _newList = [];
  Future<void> _getNewsList() async {
    var connect = await MySqlConnection.connect(mysqlSettings);
    var results = await connect.query("""
SELECT *, category.name c_name, users.name u_name FROM news 
INNER JOIN users ON users.user_id = news.user_id
INNER JOIN category ON news.category_id = category.category_id
ORDER BY news.news_id desc
""");

    for (var item in results) {
      _newList.add({
        "news_id": item.fields['news_id'],
        "category_id": item.fields['category_id'],
        "thumbnail": item.fields['thumbnail'],
        "title": item.fields['title'],
        "content": item.fields['content'],
        "user_id": item.fields['user_id'],
        "c_name": item.fields['c_name'],
        "u_name": item.fields['u_name'],
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getNewsList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 250,
            child: Image.network(
                'https://www.gamelivestory.com/images/article/genshin-impact-reveals-kuki-shinobu-character-demo-main.webp'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _newList.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.network(_newList[index]['thumbnail']),
                    title: Text(_newList[index]['title']),
                    subtitle: Text(_newList[index]['c_name']),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
