
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

IconButton copyButton(String content, BuildContext context){
  return  IconButton(
    onPressed: () {
      // quote copy here
     if(content!= "" ){
       FlutterClipboard.copy(content);
       const snackBar = SnackBar(backgroundColor:Colors.black,
         content: Text("Copied to the Clipboard!", style: TextStyle(color: Colors.white),),
         duration: Duration(milliseconds: 600),);
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
     }
    },

    iconSize: 35,
    icon: const Icon(Icons.content_copy),
    tooltip: 'copy',
    color: Theme.of(context).colorScheme.primary,
  );
}