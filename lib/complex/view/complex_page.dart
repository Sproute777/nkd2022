import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../complex.dart';
import 'complex_view.dart';

class ComplexPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ComplexPage());
  }

  const ComplexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => 
       ComplexListBloc(
           repository: context.read<ComplexRepository>()) ,
         child: const ComplexView());
  }
}
