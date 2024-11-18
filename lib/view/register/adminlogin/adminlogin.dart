
import 'package:flutter/material.dart';

import '../../../widget/side_continer.dart';
import 'side_input_adminlogin.dart';

class Regiteradmin extends StatelessWidget {
  Regiteradmin({
    super.key,
  });
  final GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolKey,
      drawer: SizedBox(width: 250, child: const SideContainer()),
      // key: context.read<MenuAppController>().scaffoldKey,
      // // drawer: SideMenu(),
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
                )),
            // We want this side menu only for large screen
            // if (Responsive.isDesktop(context))
            //   const Expanded(
            //     // default flex = 1
            //     // and it takes 1/6 part of the screen
            //     flex: 2,
            //     child: SideContainer(),
            //   ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 4,
              child: adminscrean(),
            ),
          ],
        ),
      ),
    );
  }
}
