import 'package:flutter/material.dart';
import 'package:latihan_responsi/api_data_source.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:latihan_responsi/view/detail_character.dart';

class CharacterPageList extends StatefulWidget {
  const CharacterPageList({Key? key}) : super(key: key);

  @override
  State<CharacterPageList> createState() => _CharacterPageListState();
}

class _CharacterPageListState extends State<CharacterPageList> {

  List? listCharacters;

  Future apicallCharacters()async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.genshin.dev/characters"));
    if(response.statusCode == 200){
      setState(() {
        listCharacters = json.decode(response.body);
      });
    }
  }

  @override

  void initState(){
    apicallCharacters();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Characters List"),
      ),
      body: ListView.builder(
          itemCount: listCharacters!.length,
          itemBuilder:(context,index){
            return Card(
              child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>
                            DetailChara(charaname : listCharacters![index].toString())));
                  },
                  child: ListTile(
                    leading: Image.network("https://api.genshin.dev/characters/"+ listCharacters![index] +"/icon"),
                    title: Text(listCharacters![index].toString()),
                  )
              ),
            );
          }
      ),
    );
  }
  
}
