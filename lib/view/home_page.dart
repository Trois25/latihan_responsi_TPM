import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latihan_responsi/view/detail_character.dart';
import 'package:latihan_responsi/view/detail_weapon.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:latihan_responsi/view/characters_list.dart';
import 'package:latihan_responsi/view/weapon_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late SharedPreferences prefs;
  String? _code;
  String? _name;

  void getShared() async{
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _code = prefs.getString("code");
      _name = prefs.getString("last");
    });
  }

  void initState(){
    super.initState();
    _code = "";
    _name = "";
    getShared();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          body: Container(
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height/2,
                    child: Image.asset('images/logogi.png')
                  ),
                  SizedBox(height: 50,),
                  Container(
                    child : _lastseen()
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 100,
                          child: ElevatedButton(
                            onPressed:() {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>
                                      CharacterPageList()));
                            },
                            child: Text('Characters'),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 40,
                          width: 100,
                          child: ElevatedButton(
                            onPressed:() {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>
                                      WeaponPageList()));
                            },
                            child: Text('Weapons'),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("https://4.bp.blogspot.com/-iz7Z_jLPL6E/XQ8eHVZTlnI/AAAAAAAAHtA/rDn9sYH174ovD4rbxsC8RSBeanFvfy75QCKgBGAs/w1440-h2560-c/genshin-impact-characters-uhdpaper.com-4K-2.jpg"), fit: BoxFit.cover)),
          ),
        ),
    );
  }

  Widget _lastseen(){
    return Column(
      children: [
        if(_name != "" && _name !=null)
          Container(
            width: 400,
            child: Card(
              child: InkWell(
                  onTap: () async{
                    if(_code == "chara"){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>DetailChara(charaname : _name!)));
                    }else{
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>DetailWeap(weapname: _name!)));
                    }
                  },
                  child: ListTile(
                    leading: Image.network("https://api.genshin.dev/" + _code! + "/" + _name! + "/icon"),
                    title: Text(_name!),
                  )
              ),
            ),
          )
      ],
    );
  }

}
