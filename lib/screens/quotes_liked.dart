import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quote_of_the_day/db/quote.dart';
import 'package:share_plus/share_plus.dart';
import '../db/db_helper.dart';

class LikedQuotes extends StatefulWidget {
  const LikedQuotes({super.key});

  @override
  State<LikedQuotes> createState() => _LikedQuotesState();
}

class _LikedQuotesState extends State<LikedQuotes> {
  final DatabaseServices _databaseServices = DatabaseServices.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Theme.of(context).colorScheme.background,
      appBar: AppBar(
        shadowColor: Colors.red,
        elevation: 4,
        title:  Text('Liked Quotes', style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: _quotesList(),
    );
  }

  Widget _quotesList() {
    return FutureBuilder(
      future: _databaseServices.getTasks(),
      builder: (context, snapshot) {
        return ListView.separated(
          itemBuilder: (context, index) {
            Quote q = snapshot.data![index];
            // We will reverse in next version...
            return Slidable(
              startActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      Share.share("${q.content}\n${q.author}");
                    },
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    icon: Icons.share,
                    label: 'Share',
                    autoClose: true,
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      FlutterClipboard.copy("${q.content}\n${q.author}");

                      const snackBar = SnackBar(backgroundColor:Colors.black,
                        content: Text("Copied to the Clipboard!", style: TextStyle(color: Colors.white),),
                        duration: Duration(milliseconds: 600),);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    icon: Icons.copy,
                    label: 'copy',
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      _databaseServices.delete(q.id);
                      const snackBar = SnackBar(
                        content: Text("Removed from Liked Quotes!", style: TextStyle(color: Colors.white),),
                        duration: Duration(milliseconds: 600),
                        backgroundColor: Colors.black,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      setState(() {});
                    },
                    backgroundColor: Theme.of(context).primaryColor,
                    icon: Icons.delete_outline_outlined,
                    label: 'Delete',
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  maxRadius: 20,
                  minRadius: 20,
                  backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  child:  Text('${index + 1}', style: TextStyle(fontWeight: FontWeight.bold,  color:Theme.of(context).colorScheme.secondary),),
                ),
                //  selectedColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                title: RichText(
                  text: TextSpan(
                    text: q.content,
                    style:  TextStyle(
                        fontSize: 22,
                        color:Theme.of(context).colorScheme.secondary,
                        fontFamily: 'CustomFont'),
                  ),
                  textAlign: TextAlign.justify,
                ),
                subtitle: Text(
                  "-${q.author}",
                  style:
                      TextStyle(fontFamily: 'CustomFont', fontSize: 18, color:Theme.of(context).colorScheme.secondary),
                ),

                trailing: SizedBox(
                  width: 20,
                  child: IconButton(
                    icon: const Icon(Icons.favorite),
                    color: Colors.red,
                    iconSize: 30,
                    onPressed: () {},
                  ),
                ),
              ),
            );
          },
          itemCount: snapshot.data?.length ?? 0,
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index){
            return Divider(
              height: 1,
                color:Theme.of(context).colorScheme.background,
            );
          },
        );
      },
    );
  }
}
