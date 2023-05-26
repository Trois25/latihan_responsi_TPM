import 'package:flutter/material.dart';
import 'package:latihan_responsi/api_data_source.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:latihan_responsi/view/detail_weapon.dart';

class WeaponPageList extends StatefulWidget {
  const WeaponPageList({Key? key}) : super(key: key);

  @override
  State<WeaponPageList> createState() => _WeaponPageListState();
}

class _WeaponPageListState extends State<WeaponPageList> {
  List? listWeapons;

  Future apicallWeapons()async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.genshin.dev/weapons"));
    if(response.statusCode == 200){
      setState(() {
        listWeapons = json.decode(response.body);
      });
    }
  }
  @override

  void initState(){
    apicallWeapons();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weapons List"),
      ),
      body: ListView.builder(
          itemCount: listWeapons!.length,
          itemBuilder:(context,index){
            return Card(
              child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>
                            DetailWeap(weapname : listWeapons![index].toString())));
                  },
                  child: ListTile(
                    leading: Image.network("https://api.genshin.dev/weapons/"+ listWeapons![index] +"/icon"),
                    title: Text(listWeapons![index].toString()),
                  )
              ),
            );
          }
      ),
    );
  }

}
