import 'package:flutter/material.dart';
import 'package:projetex/constants/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      kBackgroundLightColor,
                      kBackgroundDarkColor
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                  )
                ),
                child: Container(),
                )
              ])
            )
          ]
        )
      ),
    );
  }
}