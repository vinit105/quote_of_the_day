import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../db/db_helper.dart';

LikeButton likeButton(String id,String content, String author, BuildContext context) {

  final DatabaseServices databaseServices = DatabaseServices.instance;
  bool added= false;
  return LikeButton(
      size: 45,
      bubblesColor: BubblesColor(
        dotPrimaryColor: Colors.pink.shade400,
        dotSecondaryColor: Colors.yellow,
        dotLastColor: Colors.purple,

      ),

    onTap: (isLiked) async {
      if (  content == "" ||  author ==""){}
      else {
        if (!isLiked && !added) {
          databaseServices.addTask(id,content, author);
          added = !added;
          const snackBar = SnackBar(backgroundColor: Colors.black,content: Text("Added to Liked Quotes!", style: TextStyle(color: Colors.white),),
            duration: Duration(milliseconds: 600),);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else{

          databaseServices.delete(id);
          added = !added;
          const snackBar = SnackBar(content: Text("Removed from Liked Quotes!", style: TextStyle(color: Colors.white),),backgroundColor: Colors.black,
            duration: Duration(milliseconds: 600),);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

        }
      }
      return !isLiked;
      },
  );

}
