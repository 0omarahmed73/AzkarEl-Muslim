import 'package:azkar_new_app/models/azkar_category_model.dart';
import 'package:azkar_new_app/pages/AzkarPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AzkarCategoriesPage extends StatelessWidget {
  final Map<String, dynamic> theme;

  AzkarCategoriesPage({required this.theme});

  @override
  Widget build(BuildContext context) {
    List<AzkarCategoryModel> categoriesList = [
      AzkarCategoryModel(name: "أذكار الصباح", path: "أذكار الصباح"),
      AzkarCategoryModel(name: "أذكار المساء", path: "أذكار المساء"),
      AzkarCategoryModel(name: "أذكار النوم", path: "أذكار النوم"),
      AzkarCategoryModel(
          name: "أذكار الاستيقاظ من النوم", path: "أذكار الاستيقاظ من النوم"),
      AzkarCategoryModel(name: "أذكار الأذان", path: "أذكار الأذان"),
      AzkarCategoryModel(
          name: "أذكار الذهاب الى المسجد", path: "أذكار الذهاب الى المسجد"),
      AzkarCategoryModel(name: "أذكار بعد الصلاة", path: "أذكار بعد الصلاة"),
      AzkarCategoryModel(name: "سنن الجمعة", path: "سنن الجمعة"),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'تصنيفات الأذكار',
              style: TextStyle(
                color: theme['text1'],
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Almarai',
              ),
            ),
          ],
        ),
        backgroundColor: theme['primary'],
      ),
      backgroundColor: theme['background'],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: categoriesList.length,
          itemBuilder: (context, index) {
            return AzkarCategory(
                theme: theme, azkarCategoryModel: categoriesList[index]);
          },
        ),
      ),
    );
  }
}

class AzkarCategory extends StatelessWidget {
  const AzkarCategory({
    super.key,
    required this.theme,
    required this.azkarCategoryModel,
  });

  final Map<String, dynamic> theme;
  final AzkarCategoryModel azkarCategoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AzkarPage.id, arguments: azkarCategoryModel.path);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme['primary'],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            azkarCategoryModel.name,
            style: TextStyle(
              color: theme['text1'],
              fontSize: 20,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
