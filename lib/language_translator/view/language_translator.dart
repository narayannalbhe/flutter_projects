import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslator extends StatefulWidget {
  const LanguageTranslator({super.key});

  @override
  State<LanguageTranslator> createState() => _LanguageTranslatorState();
}

class _LanguageTranslatorState extends State<LanguageTranslator> {
  var languages = ['Hindi', 'English', 'Marathi'];
  var originLanguage = 'From';
  var destinationLanguage = 'To';
  var output = '';

  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    if (src == '--' || dest == '--') {
      setState(() {
        output = 'Failed to translate: Select languages';
      });
      return;
    }

    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);

    setState(() {
      output = translation.text;
    });
  }

  String getLanguageCode(String language) {
    switch (language) {
      case "English":
        return 'en';
      case 'Hindi':
        return 'hi';
      case "Marathi":
        return 'mar';
      default:
        return "--";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Language Translator',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Language Translator',style: TextStyle(
                  fontSize: 24,fontWeight: FontWeight.bold
                ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton(
                        focusColor: Colors.deepPurple,
                        iconDisabledColor: Colors.deepPurple,
                        iconEnabledColor: Colors.deepPurple,
                        hint: Text(
                          originLanguage,
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: languages.map((String dropDownStringItem) {
                          return DropdownMenuItem(
                            child: Text(dropDownStringItem),
                            value: dropDownStringItem,
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            originLanguage = value!;
                          });
                        }),

                    DropdownButton(
                        focusColor: Colors.blue,
                        iconDisabledColor: Colors.white,
                        iconEnabledColor: Colors.deepPurple,
                        hint: Text(
                          destinationLanguage,
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: languages.map((String dropDownStringItem) {
                          return DropdownMenuItem(
                            child: Text(dropDownStringItem),
                            value: dropDownStringItem,
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            destinationLanguage = value!;
                          });
                        }),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: languageController,
                  cursorColor: Colors.deepPurple,
                  autofocus: false,
                  style: TextStyle(color: Colors.deepPurple),
                  decoration: InputDecoration(
                    labelText: 'Please enter your text...',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.deepPurple),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple, width: 1),
                    ),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    translate(
                      getLanguageCode(originLanguage),
                      getLanguageCode(destinationLanguage),
                      languageController.text.toString(),
                    );
                  },
                  child: Text('Translate'),
                ),
                SizedBox(height: 20),
                Text(
                  '\n$output',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
