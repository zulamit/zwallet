import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:warp_api/warp_api.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'main.dart';
import 'generated/l10n.dart';

class RestorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RestorePageState();
}

class _RestorePageState extends State<RestorePage> {
  final _formKey = GlobalKey<FormState>();
  final _keyController = TextEditingController();
  final _nameController = TextEditingController();
  var _validKey = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${coin.symbol} Wallet"),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: S.of(context).accountName),
                    controller: _nameController,
                    validator: (String name) {
                      if (name == null || name.isEmpty)
                        return S.of(context).accountNameIsRequired;
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        decoration: InputDecoration(
                            labelText: S.of(context).key,
                            hintText:
                                S.of(context).enterSeed),
                        minLines: 4,
                        maxLines: 4,
                        controller: _keyController,
                        onChanged: _checkKey,
                      )),
                      IconButton(
                          icon: new Icon(MdiIcons.qrcodeScan), onPressed: _onScan)
                    ],
                  ),
                  ButtonBar(children:
                  confirmButtons(context, _validKey ? _onOK : null, okLabel: S.of(context).add, okIcon: Icon(Icons.add)))
                ]))));
  }

  _onOK() async {
    if (_formKey.currentState.validate()) {
      final account =
          WarpApi.newAccount(_nameController.text, _keyController.text);
      print("$account");
      if (account < 0) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                title: Text(S.of(context).duplicateAccount),
                content: Text(S.of(context).thisAccountAlreadyExists),
                actions: [
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      label: Text(S.of(context).ok),
                      icon: Icon(Icons.done))
                ]));
      }
      else {
        await accountManager.refresh();
        await accountManager.setActiveAccountId(account);
        if (_keyController.text != "") {
          await rescanDialog(context, () {
            WarpApi.rewindToHeight(0);
            Navigator.of(context).pop();
          });
        }
        else if (accountManager.accounts.length == 1)
          WarpApi.skipToLastHeight(); // single new account -> quick sync
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/account');
      }
    }
  }

  _checkKey(key) {
    setState(() {
      _validKey = key == "" || WarpApi.validKey(key);
    });
  }

  void _onScan() async {
    var code = await BarcodeScanner.scan();
    setState(() {
      final key = code.rawContent;
      _keyController.text = key;
      _validKey = key == "" || WarpApi.validKey(key);
    });
  }
}
