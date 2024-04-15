// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:chat_realm/realm/app_services.dart';
import 'package:provider/provider.dart';
import 'package:chat_realm/realm/realm_services.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);
    return AppBar(
      title: Text(realmServices.currentUser?.profile.email ?? ""),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(
          icon: Icon(realmServices.offlineModeOn ? Icons.wifi_off_rounded : Icons.wifi_rounded),
          onPressed: () async => await realmServices.sessionSwitch(),
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async => await logOut(context, realmServices),
        ),
      ],
    );
  }

  Future<void> logOut(BuildContext context, RealmServices realmServices) async {
    final appServices = Provider.of<AppServices>(context, listen: false);
    appServices.logOut();
    await realmServices.close();
    Navigator.pushNamed(context, '/login');
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
