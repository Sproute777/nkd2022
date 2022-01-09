import 'package:flutter/material.dart';
import 'complex_view.dart';

class ComplexPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ComplexPage());
  }

  const ComplexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ComplexView();
  }
}
