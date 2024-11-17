import 'package:car_maintenance_technicians/view/home/side_home/side_home.dart';

import 'package:car_maintenance_technicians/widget/side_continer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final technicalId;
  HomePage({super.key, required this.technicalId});

  final GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolKey,
      drawer: SizedBox(width: 250, child: const SideContainer()),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  scaffolKey.currentState!.openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                )), // We want this side menu only for large screen

            // if (!Responsive.isMobile(context))
            //   const Expanded(
            //     flex: 2,
            //     // default flex = 1
            //     // and it takes 1/6 part of the screen
            //     child: SideContainer(),
            //   ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 4,
              child: SideHome(
                technicalId: technicalId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
