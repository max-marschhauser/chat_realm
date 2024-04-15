import 'package:flutter/material.dart';

Widget formLayout(BuildContext context, Widget? contentWidget) {
  return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
          color: Colors.grey.shade100,
          padding: const EdgeInsets.fromLTRB(50, 25, 50, 25),
          child: Center(
            child: contentWidget,
          )));
}

Widget loginField(TextEditingController controller, {String? labelText, String? hintText, bool? obscure}) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: TextField(obscureText: obscure ?? false, controller: controller, decoration: InputDecoration(border: const OutlineInputBorder(), labelText: labelText, hintText: hintText)),
  );
}

Widget loginButton(BuildContext context, {void Function()? onPressed, Widget? child}) {
  return Container(
    height: 50,
    width: 250,
    margin: const EdgeInsets.symmetric(vertical: 25),
    child: ElevatedButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(color: Colors.white, fontSize: 20)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)))),
      onPressed: onPressed,
      child: child,
    ),
  );
}

extension ShowSnack on SnackBar {
  void show(BuildContext context, {int durationInSeconds = 15}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(this);
    Future.delayed(Duration(seconds: durationInSeconds)).then((value) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    });
  }
}

SnackBar errorMessageSnackBar(BuildContext context, String title, String message) {
  return SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: Colors.grey,
      dismissDirection: DismissDirection.none,
      content: SizedBox(
          height: 105,
          child: Center(
            child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )),
          )));
}

Container waitingIndicator() {
  return Container(
    color: Colors.black.withOpacity(0.2),
    child: const Center(child: CircularProgressIndicator()),
  );
}
