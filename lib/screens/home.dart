import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';
import 'package:quote_of_the_day/screens/quotes_liked.dart';
import '../buttons/content_copy_button.dart';
import '../buttons/like_button.dart';
import '../buttons/share_button.dart';
import '../model/model.dart';
import '../provider/theme_provider.dart';
import '../services/remoteServices.dart';
import '../theme/light_theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Welcome data = Welcome(id: '', content: '', author: '', length: 2);
  var isLoaded = false;
  getData() async {
    data = (await Remote().getPost())!;
    setState(() {
      isLoaded = true;
    });
  }

  bool isConnectedToInternet = false;

  StreamSubscription? _internetConnectionStreamSubscription;

  @override
  void initState()  {
    super.initState();
    getData();
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            isConnectedToInternet = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            isConnectedToInternet = false;
          });
          break;
        default:
          setState(() {
            isConnectedToInternet = false;
          });
          break;
      }
    });


  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          //Theme.of(context).colorScheme.background,
          appBar: AppBar(
            shadowColor: Colors.red,
            elevation: 4,
            actions: [
              IconButton(
                  icon: setI(),
                  iconSize: 30,
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                  }),
              Padding(
                padding: const EdgeInsets.fromLTRB(6.0,3,10,0),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LikedQuotes()));
                  },
                  iconSize: 30,
                  icon: const Icon(CupertinoIcons.heart_circle_fill),
                  tooltip: 'liked Quote',
                  color: Colors.red,
                ),
              )
            ],
            title:  Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Text(
                    'Today\'s Quote',
                    style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.secondary),
                  ),
              ),

            centerTitle: false,
          //  backgroundColor: Colors.grey.shade200,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor
          ),
          body:  StatefulBuilder(
            builder: (context, internalStat){
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 400,
                        width: 380,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                spreadRadius: 5,
                                blurStyle: BlurStyle.outer,
                                color: Colors.grey.shade900),
                          ],
                          color:  Theme.of(context).hintColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                copyButton((data.content + data.author), context)
                              ],
                            ),
                            SizedBox(
                              height: 299,
                              child: SingleChildScrollView(
                                child: Visibility(
                                  visible: isLoaded,
                                  replacement:  Center(
                                    child:Visibility(
                                      visible: !isConnectedToInternet ,
                                      replacement: const CircularProgressIndicator(),
                                      child:  Column(
                                        children: [
                                          Icon(Icons.wifi_off, size: 50,color:Theme.of(context).colorScheme.secondary,),
                                           Text('No Internet', style: TextStyle(color:Theme.of(context).colorScheme.primary, fontSize: 50),),
                                        ],
                                      ),
                                    ),
                                  ),
                                  child: RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 40,
                                            color: Theme.of(context).colorScheme.secondary,
                                            fontFamily: 'CustomFont'),
                                        text: data.content),
                                  ),
                                ),
                              ),
                            ),

                            // ),
                            Container(
                              height: 50,
                              width: 380,
                              color: Theme.of(context).colorScheme.tertiary,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: RichText(
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontSize: 40,
                                          color: Theme.of(context).colorScheme.secondary,
                                          fontFamily: 'CustomFont'),
                                      text: ('-${data.author}')),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      shareButton((data.content + data.author), 45, context),
                      // IconButton(onPressed: () {
                      //   if (data.content == null || data.content == "") return;
                      //   _databaseServices.addTask(data.content!);
                      // }, icon: Icon(Icons.favorite)),
                      likeButton(data.id, data.content, data.author, context),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        isLoaded = false;
                        data.author = "";
                        getData();
                        internalStat((){});
                      },
                      child: const Text('NEXT')),
                ],
              );
            },
          ),
    );
  }

  Icon setI() {
    if (lightTheme == ThemeProvider.getTheme()) {
      return const Icon(Icons.dark_mode_outlined);
    } else {
      return const Icon(Icons.sunny);
    }
  }
}
