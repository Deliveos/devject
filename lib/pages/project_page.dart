import 'package:clipboard/clipboard.dart';
import 'package:devject/cubit/projects_cubit.dart';
import 'package:devject/cubit/user_cubit.dart';
import 'package:devject/models/project.dart';
import 'package:devject/models/user.dart';
import 'package:devject/utils/size.dart';
import 'package:devject/widgets/backdrop_filter_container.dart';
import 'package:devject/widgets/project_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'add_project.dart';
import 'settings_page.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key, required this.project}) : super(key: key);
  static const routeName = "ProjectPage";

  final Project project;

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
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
      builder: (context, user) {
        return BlocBuilder<ProjectsCubit, List<Project>>(
          builder: (context, projects) {
            return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).backgroundColor,
                    title: Text(
                      widget.project.name,
                      style: Theme.of(context).textTheme.subtitle1
                    ),
                    // actions: [
                    //   IconButton(
                    //     onPressed: () => Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const SettingsPage()
                    //       )
                    //     ),
                    //     icon: Icon(Icons.settings,
                    //       color: Theme.of(context).textTheme.bodyText1!.color,
                    //       size: 20
                    //     )
                    //   )
                    // ]
                  ),
                  body: Center(
                    child: Container(
                      padding: EdgeInsets.all(AppSize.width(context, 20)),
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.background,
                            Theme.of(context).colorScheme.onBackground
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
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
                                if(widget.project.responsible.isNotEmpty)
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: buildResponsible(context, widget.project.responsible),),
                                ),
                              if(widget.project.responsible.isNotEmpty)
                                SizedBox(
                                  height: ScreenSize.height(context, 3),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      padding: EdgeInsets.only(left: AppSize.width(context, 20)),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).inputDecorationTheme.fillColor!.withOpacity(0.3),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(50),
                                          topLeft: Radius.circular(50)
                                        )
                                      ),
                                      child: Center(
                                        child: Text(
                                          user != null ? user.nickname : "...",
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
                          // if (projects.isNotEmpty)
                          //   Expanded(
                          //     flex: 4,
                          //     child: ListView.builder(
                          //       controller: _controller,
                          //       itemCount: projects.length,
                          //       itemBuilder: (context, index) => ProjectContainer(projects[index])
                          //     ),
                          //   )
                          // else
                          //   Expanded(
                          //     flex: 4,
                          //     child: Text(
                          //       AppLocalizations.of(context)!.noProjects,
                          //       style: Theme.of(context).textTheme.bodyText1,
                          //     )
                          //   )
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
                    onPressed: (){
                      Navigator.pushNamed(context, AddProjectPage.routeName);
                    },
                  ),
                );
          },
        );
      },
    );
  }

  List<Widget> buildResponsible(BuildContext context, List<User> responsible) {
    final List<Widget> res = [];
    for (int i = 0; i < responsible.length; i++) {
      res.add(BackdropFilterContaiter(
        padding: EdgeInsets.all(ScreenSize.width(context, 5)),
          child: Column(
            children: [
              responsible[i].image != null
              // TODO: create image view
              ? Container()
              : SvgPicture.asset("assets/images/avatar.svg", width: 50, height: 50,),
              SizedBox(height: ScreenSize.height(context, 1)),
              Text(responsible[i].name),
              SizedBox(height: ScreenSize.height(context, 1)),
              Text(responsible[i].nickname, style: Theme.of(context).textTheme.bodyText1),
              SizedBox(height: ScreenSize.height(context, 1)),
            ]
          )
        )
      );
      res.add(SizedBox(width: ScreenSize.width(context, 5)));
    }
    return res;
  }
}
