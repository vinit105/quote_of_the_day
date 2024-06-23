import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
IconButton shareButton(param0, double iconSize, BuildContext context){
  return  IconButton(
    onPressed: () async {
      await Share.share(param0);
    },
    iconSize: iconSize,
    icon: const Icon(Icons.share),
    tooltip: 'share',
    color:Theme.of(context).colorScheme.primary,
  );
}