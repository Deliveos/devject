import 'package:clipboard/clipboard.dart';
import 'package:devject/utils/size.dart';
import 'package:devject/widgets/preloading_task_container.dart';
import 'package:flutter/material.dart';

import '../settings_page.dart';

class PreloadingMainPage extends StatefulWidget {
  const PreloadingMainPage({Key? key}) : super(key: key);
  static const routeName = "MainPage";

  @override
  _PreloadingMainPageState createState() => _PreloadingMainPageState();
}

class _PreloadingMainPageState extends State<PreloadingMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          "Mikaelyan Eduard", 
          style: Theme.of(context).textTheme.subtitle1
        ),
        actions: [
        IconButton(
          onPressed: () => Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => const SettingsPage()
            )
          ), 
          icon: Icon(
            Icons.settings, 
            color: Theme.of(context).textTheme.bodyText1!.color,
            size: 20
          )
        )
      ]),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(AppSize.width(context, 20)),
          height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColorLight,
                  Theme.of(context).primaryColorDark
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                height: AppSize.height(context, 180),
                child: FittedBox(
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fill,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.width(context, 100)),
                          child: Container(
                            color: Theme.of(context).inputDecorationTheme.fillColor!.withOpacity(0.5),
                            height: AppSize.width(context, 100), 
                            width: AppSize.width(context, 100), 
                          )
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.height(context, 5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            padding: EdgeInsets.only(left: AppSize.width(context, 20)),
                            // width: AppSize.width(context, 120),
                            decoration: BoxDecoration(
                              color: Theme.of(context).inputDecorationTheme.fillColor!.withOpacity(0.3),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(50), 
                                topLeft: Radius.circular(50))
                            ),
                            child: Center(
                              child: Text(
                                "deliveosdars",
                                overflow: TextOverflow.clip,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Theme.of(context).inputDecorationTheme.fillColor!.withOpacity(0.3),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(50), 
                                topRight: Radius.circular(50)
                              )
                            ),
                            child: IconButton(
                              onPressed: () {
                                FlutterClipboard.copy("deliveos");
                              }, 
                              icon: Icon(
                                Icons.content_copy,
                                size: 20, 
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5)
                              )
                            )
                          )
                        ]
                      )
                    ]
                  )
                )
              ),
              Column(
                children: const [
                  PreloadingTaskContainer(),
                ],
              )
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add, 
          size: 30, 
          color: Theme.of(context).textTheme.bodyText1!.color
        ),
        onPressed: (){},
      ),
    );
  }
}

