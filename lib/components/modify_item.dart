import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_realm/realm/schemas.dart';
import 'package:chat_realm/realm/realm_services.dart';
import 'package:chat_realm/components/widgets.dart';

class ModifyItemForm extends StatefulWidget {
  final Item item;

  const ModifyItemForm(this.item, {super.key});

  @override
  _ModifyItemFormState createState() => _ModifyItemFormState(item);
}

class _ModifyItemFormState extends State<ModifyItemForm> {
  final _formKey = GlobalKey<FormState>();
  final Item item;
  late TextEditingController _summaryController;
  late ValueNotifier<bool> _isCompleteController;

  _ModifyItemFormState(this.item);

  @override
  void initState() {
    _summaryController = TextEditingController(text: item.message);
    _isCompleteController = ValueNotifier<bool>(true)..addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    _summaryController.dispose();
    _isCompleteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context, listen: false);
    return formLayout(
        context,
        Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _summaryController,
                  validator: (value) => (value ?? "").isEmpty ? "Please enter some text" : null,
                  onFieldSubmitted: (value) async {
                    await update(context, realmServices, item, _summaryController.text);
                  },
                ),
              ],
            )));
  }

  Future<void> update(BuildContext context, RealmServices realmServices, Item item, String summary) async {
    if (_formKey.currentState!.validate()) {
      await realmServices.updateItem(item, message: summary);

      Navigator.pop(context);
    }
  }
}
