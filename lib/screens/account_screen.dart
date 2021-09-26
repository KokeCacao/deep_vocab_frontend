import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../view_models/auth_view_model.dart';
import '../widgets/user_screen/setting_tab.dart';
import '../widgets/learning_screen/no_transition_dialog.dart';
import 'login_screen.dart';

class AccountScreen {
  static void showAccountScreen(BuildContext context) {
    double borderRadius = 10;
    BorderRadius border =
        BorderRadius.vertical(top: Radius.circular(borderRadius));
    PanelController panelController = PanelController();

    showNoTransitionDialog(
        context: context,
        builder: (BuildContext context) {
          const EdgeInsetsGeometry padding =
              EdgeInsets.symmetric(horizontal: 20, vertical: 10);

          return SlidingUpPanel(
              color: Colors.white70,
              backdropEnabled: true,
              backdropOpacity: 0.4,
              defaultPanelState:
                  PanelState.CLOSED, // first closed to show animation
              minHeight: 0, // open by dialog
              controller: panelController,
              onPanelClosed: () {
                Navigator.of(context).pop();
              }, // close dialog
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              borderRadius: border,
              panelBuilder: (ScrollController scrollController) {
                panelController.open(); // hack to show opening animation
                return Material(
                    type: MaterialType.transparency,
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Padding(
                          padding: padding,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            clipBehavior: Clip.antiAlias,
                            child: SettingTab(
                                textFront: "更改密码",
                                icon: Icons.timer,
                                textBack: "",
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed("/login_screen", arguments: {
                                    "index": 0,
                                    "state": LoginScreenEnum.recover,
                                  });
                                }),
                          ),
                        ),
                        Padding(
                          padding: padding,
                          child: ElevatedButton(
                            child: Text("Logout"),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                            onPressed: () {
                              AuthViewModel authViewModel =
                                  Provider.of<AuthViewModel>(context,
                                      listen: false);
                              if (authViewModel.isLoggedIn) {
                                authViewModel.logout();
                                panelController.close();
                              }
                            },
                          ),
                        ),
                      ],
                    ));
              });
        });
  }
}
