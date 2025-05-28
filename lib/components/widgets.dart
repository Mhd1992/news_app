import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_app/components/widget_main.dart';
import 'package:new_app/modules/web_view/web_view_screen.dart';

Widget buildArticle(article,context)=>InkWell(
  onTap: (){
   navigateTo(context, WebViewScreen(url: article['url']));
  },
  child: Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image:  DecorationImage(
              image: article['urlToImage'] !=null ?NetworkImage(
                  '${article['urlToImage']}'
              ):AssetImage('assets/noImage.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 20,
      ),
       Expanded(
        child: SizedBox(
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${article['title']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${article['publishedAt']}',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ],
          ),
        ),
      )
    ],
  ),
);

Widget buildArticleList(List<dynamic>list,{bool searched=false})=> ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context)=>ListView.separated(
        itemBuilder: (context, index) => buildArticle(list[index],context),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: list.length),
    fallback: (context) => (searched)?Center(child: Text('noData'),):const Center(child: CircularProgressIndicator()),

);