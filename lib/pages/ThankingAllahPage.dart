import 'package:azkar_new_app/controller/controller.dart';
import 'package:azkar_new_app/models/bless_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart'; // Import the uuid package

class ThankingAllahPage extends StatefulWidget {
  ThankingAllahPage({super.key});
  static String id = 'ThankingAllahPage';

  @override
  State<ThankingAllahPage> createState() => _ThankingAllahPageState();
}

class _ThankingAllahPageState extends State<ThankingAllahPage> {
  List<BlessModel> blesses = [];

  @override
  void initState() {
    super.initState();
    loadBlesses();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reset all blesses to done = false when the page is initialized
    resetBlesses();
  }

  void resetBlesses() {
    setState(() {
      blesses.forEach((bless) {
        bless.done = false;
      });
    });
  }

  void loadBlesses() {
    final GetStorage storage = GetStorage();
    final dynamic storedData = storage.read('blesses');
    if (storedData != null) {
      blesses = (storedData as List)
          .map((e) => BlessModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  void saveBlesses() {
    final GetStorage storage = GetStorage();
    List<Map<String, dynamic>> blessesToStore =
        blesses.map((e) => e.toJson()).toList();
    storage.write('blesses', blessesToStore);
  }

  void saveBless(BlessModel bless) {
    setState(() {
      // Generate a unique ID for the new bless
      bless.id = generateUniqueId();
      blesses.add(bless); // Add the new bless to the list

      // Save blesses to storage
      saveBlesses();
    });
  }

  num generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  void removeBless(BlessModel bless) {
    setState(() {
      blesses.remove(bless);
      saveBlesses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.find<Controller>();
    final GetStorage storage = GetStorage();
    Map theme = storage.read('theme') == 'light'
        ? {
            'primary': Colors.deepPurple,
            'text1': Colors.white,
            'iconMode': Icon(Icons.sunny),
            'background': Colors.white,
            'cardBg': Color.fromRGBO(250, 243, 255, 1),
            'text2': Colors.black,
            'button1': Color.fromRGBO(45, 175, 240, 1)
          }
        : {
            'primary': Color.fromRGBO(255, 195, 0, 1),
            'text1': Colors.black,
            'iconMode': Icon(Icons.nights_stay),
            'background': Color.fromRGBO(0, 29, 61, 1),
            'cardBg': Color.fromRGBO(31, 57, 96, 1),
            'text2': Colors.white,
            'button1': Color.fromRGBO(255, 195, 0, 1)
          };

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'شكر النعم',
              style: TextStyle(
                  color: theme['text1'],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Almarai'),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.check_circle_outline_rounded)),
          ],
        ),
        backgroundColor: theme['primary'],
        iconTheme: IconThemeData(color: theme['text1']),
      ),
      backgroundColor: theme['background'],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                elevation: 10,
                color: theme['cardBg'],
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Text(
                    'كان بعض السلف يسمي (الشكر): الحافظ الجالب؛ لأنه يحفظ النعم الموجودة، ويجلب النعم المفقودة',
                    style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: theme['text2']),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Card(
              elevation: 10,
              color: theme['cardBg'],
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        AddButton(
                          blessLength: blesses.length,
                          theme: theme,
                          onAdd: saveBless,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ...blesses
                        .map((bless) => BlessItem(
                              save: saveBless,
                              remove: removeBless,
                              theme: theme,
                              bless: bless,
                            ))
                        .toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  final Map theme;
  final Function(BlessModel) onAdd;
  final int blessLength;

  const AddButton({
    super.key,
    required this.theme,
    required this.onAdd,
    required this.blessLength,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(
            context: context,
            onSave: onAdd,
            blessLength: blessLength,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            color: theme['primary'], borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_circle_rounded,
              color: theme['text1'],
            ),
            SizedBox(width: 10),
            Text(
              'إضافة',
              style: TextStyle(
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: theme['text1']),
            )
          ],
        ),
      ),
    );
  }
}

class BlessItem extends StatefulWidget {
  final Map theme;
  final BlessModel bless;
  final Function(BlessModel) save;
  final Function(BlessModel) remove;

  BlessItem({
    super.key,
    required this.theme,
    required this.bless,
    required this.save,
    required this.remove,
  });

  @override
  State<BlessItem> createState() => _BlessItemState();
}

class _BlessItemState extends State<BlessItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.theme['background'],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  widget.remove(widget.bless);
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: widget.theme['primary'],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.delete,
                    color: widget.theme['text1'],
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.bless.done = !widget.bless.done;
              });
            },
            child: Row(
              children: [
                Text(
                  widget.bless.name,
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: widget.theme['text2'],
                    decoration: widget.bless.done
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: widget.theme['text2'],
                    decorationThickness: widget.bless.done ? 2.0 : 0.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 10),
                Icon(
                  widget.bless.done
                      ? Icons.check_circle
                      : Icons.check_circle_outline,
                  color: widget.theme['text2'],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildPopupDialog({
  required BuildContext context,
  required Function(BlessModel) onSave,
  required int blessLength,
  BlessModel? existingBless,
}) {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
      TextEditingController(text: existingBless?.name ?? '');

  return AlertDialog(
    title: Text(
      existingBless == null ? 'إضافة نعمة جديدة' : 'تعديل النعمة',
      style: TextStyle(
        fontFamily: 'Almarai',
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      textAlign: TextAlign.end,
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء التأكد من ملأ الخانة';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      onSave(BlessModel(
                        id: existingBless?.id ?? blessLength,
                        name: _nameController.text,
                        done: existingBless?.done ?? false,
                      ));
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    existingBless == null ? 'إضافة' : 'تعديل',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
