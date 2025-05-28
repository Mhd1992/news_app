import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/components/widgets.dart';
import 'package:new_app/layouts/news_app/cubit/news_cubit.dart';
import 'package:new_app/layouts/news_app/cubit/news_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var list =NewsCubit.get(context).business;
        return  buildArticleList(list);

      },
    );
  }
}
