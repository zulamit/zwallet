import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warp/history.dart';
import 'package:warp_api/warp_api.dart';

import 'about.dart';
import 'account2.dart';
import 'budget.dart';
import 'contact.dart';
import 'generated/l10n.dart';
import 'main.dart';
import 'note.dart';
import 'store.dart';

class HomePage extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;
  StreamSubscription? _syncDispose;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
    Future.microtask(() async {
      await syncStatus.update();
      await active.updateBalances();
      await priceStore.fetchCoinPrice(active.coin);
      await Future.delayed(Duration(seconds: 3));
      await syncStatus.sync();
      Timer.periodic(Duration(seconds: 15), (Timer t) async {
        syncStatus.sync();
        await active.updateBalances();
      });
    });
    _syncDispose = syncStream.listen((height) {
      final h = height as int?;
      if (h != null) {
        syncStatus.setSyncHeight(h);
        eta.checkpoint(h, DateTime.now());
      } else {
        WarpApi.mempoolReset(active.coin, syncStatus.latestHeight);
      }
    });
  }

  @override
  void dispose() {
    _syncDispose?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Observer(builder: (context) {
        final s = S.of(context);
        final theme = Theme.of(context);
        final simpleMode = settings.simpleMode;

        Widget button = Container();
        switch (_tabIndex) {
          case 0:
            button = FloatingActionButton(
              onPressed: _onSend,
              backgroundColor: theme.colorScheme.secondary,
              child: Icon(Icons.send),
            );
        }

        final menu = PopupMenuButton<String>(
          itemBuilder: (context) {
            return [
              PopupMenuItem(child: Text(s.accounts), value: "Accounts"),
              PopupMenuItem(child: Text(s.backup), value: "Backup"),
              PopupMenuItem(child: Text(s.rescan), value: "Rescan"),
              if (!simpleMode && active.canPay)
                PopupMenuItem(child: Text(s.coldStorage), value: "Cold"),
              if (!simpleMode)
                PopupMenuItem(child: Text(s.multipay), value: "MultiPay"),
              if (!simpleMode)
                PopupMenuItem(child: Text(s.broadcast), value: "Broadcast"),
              PopupMenuItem(child: Text(s.settings), value: "Settings"),
              PopupMenuItem(child: Text(s.help), value: "Help"),
              PopupMenuItem(child: Text(s.about), value: "About"),
            ];
          },
          onSelected: _onMenu,
        );

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("${active.account.name}"),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: [
                Tab(text: s.account),
                Tab(text: s.notes),
                Tab(text: s.history),
                Tab(text: s.budget),
                Tab(text: s.tradingPl),
                Tab(text: s.contacts),
              ],
            ),
            actions: [menu],
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              AccountPage2(),
              NoteWidget(),
              HistoryWidget(),
              BudgetWidget(),
              PnLWidget(),
              ContactsTab(),
            ],
          ),
          floatingActionButton: button,
        );
      });

  _onSend() {
    Navigator.of(this.context).pushNamed('/send');
  }

  _onMenu(String choice) {
    switch (choice) {
      case "Accounts":
        Navigator.of(this.context).pushNamed('/accounts');
        break;
      case "Backup":
        _backup();
        break;
      case "Rescan":
        _rescan();
        break;
      case "Cold":
        _cold();
        break;
      case "MultiPay":
        _multiPay();
        break;
      case "Broadcast":
        _broadcast();
        break;
      case "Settings":
        _settings();
        break;
      case "Help":
        launch(DOC_URL);
        break;
      case "About":
        showAbout(this.context);
        break;
    }
  }

  _backup() async {
    final didAuthenticate = await authenticate(context, S.of(context).pleaseAuthenticateToShowAccountSeed);
    if (didAuthenticate) {
      Navigator.of(context).pushNamed('/backup');
    }
  }

  _rescan() async {
    final approved = await rescanDialog(context);
    if (approved) {
      syncStatus.rescan(context);
    }
  }

  _cold() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
            title: Text(S.of(context).coldStorage),
            content:
            Text(S.of(context).doYouWantToDeleteTheSecretKeyAndConvert),
            actions: confirmButtons(context, _convertToWatchOnly,
                okLabel: S.of(context).delete)));
  }

  _multiPay() {
    Navigator.of(context).pushNamed('/multipay');
  }

  _broadcast() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final res = WarpApi.broadcast(active.coin, result.files.single.path!);
      final snackBar = SnackBar(content: Text(res));
      rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);
    }
  }

  _convertToWatchOnly() {
    active.convertToWatchOnly();
    Navigator.of(context).pop();
  }

  _settings() {
    Navigator.of(context).pushNamed('/settings');
  }

}
