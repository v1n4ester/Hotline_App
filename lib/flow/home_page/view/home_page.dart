import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotline_app/api/products_repository/products_repository.dart';
import 'package:hotline_app/di/setup_di.dart';
import 'package:hotline_app/flow/home_page/bloc/home_bloc.dart';
import 'package:hotline_app/flow/home_page/view/home_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        productsRepository: getIt.get<ProductsRepository>(),
      )..add(const HomeInitialEvent()),
      child: const HomeForm(),
    );
  }
}
