import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_realm/components/message_list.dart';
import 'package:chat_realm/components/app_bar.dart';
import 'package:chat_realm/realm/realm_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newMessageController = TextEditingController();
  final FocusNode _newMessageFocusController = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _newMessageFocusController.requestFocus());

    super.initState();
  }

  @override
  void dispose() {
    _newMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<RealmServices?>(context, listen: false) == null
        ? Container()
        : Scaffold(
            appBar: ChatAppBar(),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Expanded(child: MessageList()),
                    Container(
                      color: Colors.white,
                      child: Form(
                        key: _formKey,
                        child: Consumer<RealmServices>(builder: (context, realmServices, child) {
                          return TextField(
                            focusNode: _newMessageFocusController,
                            controller: _newMessageController,
                            onSubmitted: (value) {
                              save(realmServices, context);
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(4),
                              border: OutlineInputBorder(),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  void save(RealmServices realmServices, BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final message = _newMessageController.text;
      realmServices.createItem(message);
      _newMessageController.text = "";
      _newMessageFocusController.requestFocus();
    }
  }
}
