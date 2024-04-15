import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:chat_realm/realm/realm_services.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:chat_realm/realm/app_services.dart';
import 'package:chat_realm/screens/homepage.dart';
import 'package:chat_realm/screens/log_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Config realmConfig = await Config.getConfig('assets/config/atlasConfig.json');

  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Config>(create: (_) => realmConfig),
        ChangeNotifierProvider<AppServices>(create: (_) => AppServices(realmConfig.appId, realmConfig.baseUrl)),
        ChangeNotifierProxyProvider<AppServices, RealmServices?>(
            create: (context) => null,
            update: (BuildContext context, AppServices appServices, RealmServices? realmServices) {
              return appServices.app.currentUser != null ? RealmServices(appServices.app) : null;
            }),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final String atlasUrl = Provider.of<Config>(context, listen: false).atlasUrl;

    final currentUser = Provider.of<RealmServices?>(context, listen: false)?.currentUser;

    return PopScope(
      onPopInvoked: (bool didPop) => false,
      child: MaterialApp(
        title: 'Flutter SDK Todo',
        debugShowCheckedModeBanner: false,
        initialRoute: currentUser != null ? '/' : '/login',
        routes: {'/': (context) => const HomePage(), '/login': (context) => const LogIn()},
      ),
    );
  }
}

class Config extends ChangeNotifier {
  late String appId;
  late String atlasUrl;
  late Uri baseUrl;

  Config._create(dynamic realmConfig) {
    appId = realmConfig['appId'];
    atlasUrl = realmConfig['dataExplorerLink'];
    baseUrl = Uri.parse(realmConfig['baseUrl']);
  }

  static Future<Config> getConfig(String jsonConfigPath) async {
    dynamic realmConfig = json.decode(await rootBundle.loadString(jsonConfigPath));

    var config = Config._create(realmConfig);

    return config;
  }
}
