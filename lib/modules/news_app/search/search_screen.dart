// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/news_cubit/news_cubit.dart';
import 'package:udemy_course/shared/news_cubit/news_states.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultFormField(
                controller: searchController,
                type: TextInputType.text,
                validate: (String value) {
                  if (value.isEmpty) {
                    return "search must not be empty";
                  }
                  return null;
                },
                onSubmit: (value) {
                  NewsCubit.get(context).getSearch(value);
                },
                onTab: () {},
                onChanged: (value) {
                  NewsCubit.get(context).getSearch(value);
                },
                label: "Search",
                prefix: Icons.search,
              ),
            ),
            Expanded(child: articleBuilder(list, context, isSearch: true)),
          ]),
        );
      },
    );
  }
}
