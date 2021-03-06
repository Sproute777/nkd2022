import 'package:bloc_app/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../ui.dart';
import 'tab_page.dart';

class ComplexView extends StatefulWidget {
  const ComplexView({Key? key}) : super(key: key);

  @override
  _ComplexViewState createState() => _ComplexViewState();
}

class _ComplexViewState extends State<ComplexView> {
  late int _currentTab;

  @override
  void initState() {
    _currentTab = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final language = AppLocalizations.of(context)!;
    return DefaultTabController(
        length: 4,
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              _currentTab = tabController.index;
            }
          });
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.grey[900]),
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                  },
                  child: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ],
              backgroundColor: Colors.grey[900],
              bottom: TabBar(
                // labelColor: Colors.white,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(text: language.onHold),
                  Tab(text: language.inProgress),
                  Tab(text: language.needsReview),
                  Tab(text: language.approved),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                TabPageIndexed(currentRow: 0),
                TabPageIndexed(currentRow: 1),
                TabPageIndexed(currentRow: 2),
                TabPageIndexed(currentRow: 3),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push<void>(ItemEditorPage.route(
                  row: _currentTab.toString(),
                ));
              },
              child: const Icon(Icons.add),
            ),
          );
        }));
  }
}
