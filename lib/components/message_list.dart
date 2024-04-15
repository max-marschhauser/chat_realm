import 'package:flutter/material.dart';
import 'package:chat_realm/components/message_item.dart';
import 'package:chat_realm/components/widgets.dart';
import 'package:chat_realm/realm/schemas.dart';
import 'package:provider/provider.dart';
import 'package:chat_realm/realm/realm_services.dart';
import 'package:realm/realm.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: StreamBuilder<RealmResultsChanges<Item>>(
            stream: realmServices.realm.query<Item>("TRUEPREDICATE SORT(_id ASC)").changes,
            builder: (context, snapshot) {
              final data = snapshot.data;

              if (data == null) return waitingIndicator();

              final results = data.results;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: results.realm.isClosed ? 0 : results.length,
                itemBuilder: (context, index) => results[index].isValid ? MessageItem(results[index]) : Container(),
              );
            },
          ),
        ),
        realmServices.isWaiting ? waitingIndicator() : Container(),
      ],
    );
  }
}
