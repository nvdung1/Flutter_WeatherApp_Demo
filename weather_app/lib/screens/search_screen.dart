import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SearchScreen();
  }
}
class _SearchScreen extends State<SearchScreen>{
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Enter a city"),),
      body:  Form(
        child: Row(
          children: [
            Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    autofocus: true,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        labelText: 'Enter a city',
                        hintText: 'Example: Chicago'
                    ),
                  ),
                )
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pop(context, _textEditingController.text);
              },
            )
          ],
        ),
      ),
    );
  }
  
}