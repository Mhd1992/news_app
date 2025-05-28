import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildArticle(article)=>Row(
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
);

Widget buildArticleList(List<dynamic>list)=>ConditionalBuilder(
  condition: list.isNotEmpty,
  builder: (context)=>ListView.separated(
      itemBuilder: (context, index) => buildArticle(list[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: list.length),
  fallback: (context) =>const Center(child: CircularProgressIndicator()),
);