import 'package:azkar_new_app/models/azkar_category_model.dart';
import 'package:azkar_new_app/pages/AzkarPage.dart';
import 'package:flutter/material.dart';

class PrayersPage extends StatelessWidget {
  final Map<String, dynamic> theme;

  PrayersPage({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'الدعاء',
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
        body: Container(
            margin: EdgeInsets.all(10),
            child: ListView(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrayerCategory(
                    theme: theme,
                    azkarCategoryModel: AzkarCategoryModel(
                        name: "أدعية قرآنية", path: "أدعية قرآنية"),
                  ),
                  PrayerCategory(
                    theme: theme,
                    azkarCategoryModel: AzkarCategoryModel(
                        name: "أدعية نبوية", path: "أدعية نبوية"),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 10,
                color: theme['cardBg'],
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                  child: Text(
                    'قال رسول الله صلى الله عليه وسلم: "الدعاء هو العبادة"',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Almarai',
                        fontSize: 17,
                        color: theme['text2']),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 10,
                color: theme['cardBg'],
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        ': وشروط إجابة الدعاء ثلاثة',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Almarai',
                            fontSize: 17,
                            color: theme['text2']),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'الأول: دعاء الله وحده لا شريك له بصدق وإخلاص، لأن الدعاء عبادة.',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Almarai',
                            fontSize: 17,
                            color: theme['text2']),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'الثاني: ألا يدعو المرء بإثم أو قطيعة رحم، وألا يستعجل',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Almarai',
                            fontSize: 17,
                            color: theme['text2']),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'الثالث: أن يدعو بقلب حاضر، موقن بالإجابة، ويحسن ظنه بربه',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Almarai',
                            fontSize: 17,
                            color: theme['text2']),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 10,
                color: theme['cardBg'],
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'ومن آداب الدعاء: افتتاحه بحمد الله والثناء عليه، والصلاة والسلام على رسول الله صلى الله عليه وسلم، وختمه بذلك، ورفع اليدين، وعدم التردد، بل ينبغي للداعي أن يعزم على الله ويلح عليه، وكذلك تحري أوقات الإجابة كالثلث الأخير من الليل، وبين الأذان والإقامة، وعند الإفطار من الصيام، وغير ذلك .',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Almarai',
                            fontSize: 17,
                            height: 2,
                            color: theme['text2']),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ])));
  }
}

class PrayerCategory extends StatelessWidget {
  const PrayerCategory({
    super.key,
    required this.theme,
    required this.azkarCategoryModel,
  });

  final Map<String, dynamic> theme;
  final AzkarCategoryModel azkarCategoryModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(AzkarPage.id, arguments: azkarCategoryModel.path);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
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
      ),
    );
  }
}
