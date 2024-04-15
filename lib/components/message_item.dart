import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_realm/components/modify_item.dart';
import 'package:chat_realm/components/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:chat_realm/realm/schemas.dart';
import 'package:chat_realm/realm/realm_services.dart';

enum MenuOption { edit, delete }

class MessageItem extends StatelessWidget {
  final Item item;

  const MessageItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);
    bool isMine = (item.ownerId == realmServices.currentUser?.id);
    return item.isValid
        ? Container(
            color: isMine ? Colors.lightGreen : Colors.lightBlue,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(item.message),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: PopupMenuButton<MenuOption>(
                    onSelected: (menuItem) => handleMenuClick(context, menuItem, item, realmServices),
                    itemBuilder: (context) => [
                      const PopupMenuItem<MenuOption>(
                        value: MenuOption.edit,
                        child: ListTile(leading: Icon(Icons.edit), title: Text("Edit item")),
                      ),
                      const PopupMenuItem<MenuOption>(
                        value: MenuOption.delete,
                        child: ListTile(leading: Icon(Icons.delete), title: Text("Delete item")),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  void handleMenuClick(BuildContext context, MenuOption menuItem, Item item, RealmServices realmServices) {
    bool isMine = (item.ownerId == realmServices.currentUser?.id);
    switch (menuItem) {
      case MenuOption.edit:
        if (isMine) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => Wrap(children: [ModifyItemForm(item)]),
          );
        } else {
          errorMessageSnackBar(context, "Edit not allowed!", "You are not allowed to edit messages \nthat don't belong to you.").show(context);
        }
        break;
      case MenuOption.delete:
        if (isMine) {
          realmServices.deleteItem(item);
        } else {
          errorMessageSnackBar(context, "Delete not allowed!", "You are not allowed to delete messages \n that don't belong to you.").show(context);
        }
        break;
    }
  }
}
