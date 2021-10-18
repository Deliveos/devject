import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projetex/constants/colors.dart';
import 'package:projetex/cubit/projects_cubit.dart';
import 'package:projetex/cubit/user_cubit.dart';
import 'package:projetex/models/project.dart';
import 'package:projetex/models/user.dart';
import 'package:projetex/pages/settings_page.dart';
import 'package:projetex/utils/size.dart';
import 'package:projetex/widgets/default_sizedbox.dart';
import 'package:projetex/widgets/preloading_task_container.dart';
import 'package:projetex/widgets/project_container.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const routeName = "MainPage";

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _controller = ScrollController();
  bool topContainerIsClosed = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        topContainerIsClosed = _controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProjectsCubit>(context).load();
    return BlocBuilder<UserCubit, User?>(
      builder: (context, state) {
        return Scaffold(
            // extendBodyBehindAppBar: true,
            appBar: AppBar(
                backgroundColor: kBackgroundLightColor,
                title: Text(
                  state != null ? state.name : "...",
                    style: Theme.of(context).textTheme.subtitle1),
                actions: [
                  IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsPage())),
                      icon: Icon(Icons.settings,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          size: 20))
                ]),
            body: Center(
                child: Container(
              padding: EdgeInsets.all(AppSize.width(context, 20)),
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [kBackgroundLightColor, kBackgroundDarkColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter,
                    height:
                        topContainerIsClosed ? 0 : AppSize.height(context, 180),
                    child: FittedBox(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fill,
                      child: Column(children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  AppSize.width(context, 100)),
                              child: Image.asset(
                                "assets/images/avatar_example.jpg",
                                height: AppSize.width(context, 100),
                                width: AppSize.width(context, 100),
                              )),
                        ),
                        const HeightSizedBox(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              padding: EdgeInsets.only(
                                  left: AppSize.width(context, 20)),
                              // width: AppSize.width(context, 120),
                              decoration: BoxDecoration(
                                  color: kInputFieldColor.withOpacity(0.3),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                      topLeft: Radius.circular(50))),
                              child: Center(
                                child: Text(
                                  state != null ? state.nickname : "...",
                                  overflow: TextOverflow.clip,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: kInputFieldColor.withOpacity(0.3),
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(50),
                                      topRight: Radius.circular(50))),
                              child: IconButton(
                                onPressed: () {
                                  FlutterClipboard.copy("deliveos");
                                },
                                icon: Icon(
                                  Icons.content_copy,
                                    size: 20,
                                    color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color!
                                      .withOpacity(0.5)
                                )
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                  BlocBuilder<ProjectsCubit, List<Project>?>(
                    builder: (context, state) {
                      if (state != null) {
                        if (state.isNotEmpty) {
                          return Expanded(
                            flex: 4,
                            child: ListView.builder(
                                controller: _controller,
                                itemCount: state.length,
                                itemBuilder: (context, index) => ProjectContainer(state[index])),
                          );
                        } else {
                          return const Expanded(
                            flex: 4,
                            child: Text("No projects")
                          );
                        }
                      }
                      return const PreloadingTaskContainer();
                    },
                  )
                  
                ],
              ),
            )));
      },
    );
  }
}
