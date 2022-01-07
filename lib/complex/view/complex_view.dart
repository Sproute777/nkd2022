import 'package:flutter/material.dart';
import 'tabpage_1.dart';
import 'tabpage_2.dart';
import 'tabpage_3.dart';
import 'tabpage_4.dart';

class ComplexView extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ComplexView());
  }

  const ComplexView({Key? key}) : super(key: key);

  @override
  _ComplexViewState createState() => _ComplexViewState();
}

class _ComplexViewState extends State<ComplexView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.grey[900]),
                onPressed: () {
                  // context.read<LoginBloc>().add(Logout());
                },
                child: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            ],
            backgroundColor: Colors.grey[900],
            bottom: const TabBar(
              // labelColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'On hold'),
                Tab(text: 'In progress'),
                Tab(text: 'Needs review'),
                Tab(text: 'Approved'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              FirstTabPage(),
              SecondTabPage(),
              ThirdTabPage(),
              FourthTabPage(),
            ],
          ),
        ));
  }
}
