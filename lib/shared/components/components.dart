// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:udemy_course/modules/news_app/web_view/web_view.dart';
import 'package:udemy_course/shared/to_do_cubit/todo_cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: background,
        ),
        child: MaterialButton(
          onPressed: function,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ));

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function onSubmit,
  required Function onTab,
  required Function onChanged,
  Function? validate,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      validator: (value) {
        return validate!(value);
      },
      controller: controller,
      keyboardType: type,
      enabled: isClickable,
      obscureText: isPassword,
      onFieldSubmitted: (s) {
        onSubmit();
      },
      onChanged: (s) => onChanged,
      onTap: () => onTab(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(
                  suffix,
                ),
                onPressed: () {
                  suffixPressed!();
                },
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model["status"]),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model["id"]);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text("${model["time"]}"),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model["title"]}",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: "new", id: model["id"]);
              },
              icon: Icon(
                Icons.menu,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: "done", id: model["id"]);
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: "archive", id: model["id"]);
              },
              icon: Icon(
                Icons.archive,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );

Widget tasksBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              " No tasks yet !",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            Text(
              "Please add some",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length,
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: article['urlToImage'] == null
            ? Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        "${article["title"]}",
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "${article["publishedAt"]}",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            : Row(
                children: [
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: NetworkImage("${article['urlToImage']}"),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: Container(
                      height: 120.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Text(
                              "${article["title"]}",
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "${article["publishedAt"]}",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,
      ),
      fallback: (context) => isSearch
          ? Container()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));
