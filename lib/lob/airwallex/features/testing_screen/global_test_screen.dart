import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zinc/lob/airwallex/constants/constants.dart';

// This is for QA testing. Do NOT push this to prod app
class GlobalTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _cardIdController = TextEditingController(text: Constants.CONNECTED_CARD_ID);
    final _cardHolderIdController = TextEditingController(text: Constants.CARD_HOLDER_ID);
    final _accountIdController =
        TextEditingController(text: Constants.CONNECTED_ACCOUNT_ID);

    return Scaffold(
      appBar: AppBar(title: Text("Edit IDs")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cardIdController,
              decoration: InputDecoration(labelText: "Card ID"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _accountIdController,
              decoration: InputDecoration(labelText: "Account ID"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cardHolderIdController,
              decoration: InputDecoration(labelText: "Card Holder Id"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Constants.CONNECTED_CARD_ID = _cardIdController.text;
                Constants.CONNECTED_ACCOUNT_ID = _accountIdController.text;
                Constants.CARD_HOLDER_ID = _cardHolderIdController.text;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("IDs updated successfully")),
                );
                context.pop();
              },
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
