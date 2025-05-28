import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/layouts/news_app/cubit/news_cubit.dart';
import 'package:new_app/layouts/news_app/cubit/news_state.dart';

import '../../components/widget_main.dart';
import '../../components/widgets.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<NewsCubit, NewsState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var list = NewsCubit.get(context).searchResult;
    return Scaffold(
      appBar: AppBar(
        
      ),
      body:  Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              defaultFormFiled(controller: searchController, type: TextInputType.text,
                onChanged:(value){
                NewsCubit.get(context).getSearchResult(value);
                
                },
                  validate: (val){
                if(val!.isEmpty){
                  return 'search must be not empty';
                }
              }, label: 'Search', prefix: Icons.search),
               
              
            ],),
          ),
          Expanded(child: buildArticleList(list))
        ],
      ),
    );
  },
);
  }
}
