import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DetailChara extends StatefulWidget {
  final String charaname;
  const DetailChara({Key? key, required this.charaname}) : super(key: key);

  @override
  State<DetailChara> createState() => _DetailCharaState();
}

class _DetailCharaState extends State<DetailChara> {

  List? listCharacterssplash;
  late SharedPreferences prefs;

  late String stringResponsedetail;
  Map? mapResponsedetail;


  Future apicallCharacterssplash()async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.genshin.dev/characters/"+ widget.charaname+"/gacha-splash"));
    if(response.statusCode == 200){
      setState(() {
        listCharacterssplash = json.decode(response.body);
      });
    }
  }

  Future apicallCharaDetail()async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.genshin.dev/characters/"+ widget.charaname));
    if(response.statusCode == 200){
      setState(() {
        stringResponsedetail = response.body;
        mapResponsedetail = json.decode(response.body);
      });
    }
  }

  Future<void> storeShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('last', widget.charaname);
    prefs.setString('code', "characters");
  }

  @override

  void initState(){
    apicallCharacterssplash();
    apicallCharaDetail();
    storeShared();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail " + widget.charaname),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black
        ),
        child: ListView(
          children: [
            Container(
                height: MediaQuery.of(context).size.height/2,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Image.network("https://api.genshin.dev/characters/"+ widget.charaname+"/gacha-splash",height:250,fit: BoxFit.fill,),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network("https://api.genshin.dev/nations/"+ mapResponsedetail!['nation'].toLowerCase() +"/icon",height:50,fit: BoxFit.fill,),
                              Image.network("https://api.genshin.dev/elements/"+ mapResponsedetail!['vision'].toLowerCase() +"/icon",height:50,fit: BoxFit.fill,),
                              Text(widget.charaname,style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white
                              ),),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < mapResponsedetail!['rarity']; i++)
                              Icon(
                                Icons.star,
                                color: Colors.white,
                              ),
                          ],
                        ),
                        Text(mapResponsedetail!['affiliation'].toString(),style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                        ),)
                      ],
                    ),
                  ],
                )
            ),
            Container(
              child: Column(
                children: [
                  ListTile(
                    leading: Image.network("https://api.genshin.dev/characters/"+ widget.charaname +"/talent-na"),
                    title: Text(mapResponsedetail!['skillTalents'][0]['unlock'].toString(),style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                    ),),
                    subtitle: Text(mapResponsedetail!['skillTalents'][0]['description'].toString(),style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                    ),),
                  ),
                  SizedBox(height: 20,),
                  ListTile(
                    leading: Image.network("https://api.genshin.dev/characters/"+ widget.charaname +"/talent-skill"),
                    title: Text(mapResponsedetail!['skillTalents'][1]['unlock'].toString(),style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                    ),),
                    subtitle: Text(mapResponsedetail!['skillTalents'][1]['description'].toString(),style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                    ),),
                  ),
                  SizedBox(height: 20,),
                  ListTile(
                    leading: Image.network("https://api.genshin.dev/characters/"+ widget.charaname +"/talent-burst"),
                    title: Text(mapResponsedetail!['skillTalents'][2]['unlock'].toString(),style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                    ),),
                    subtitle: Text(mapResponsedetail!['skillTalents'][2]['description'].toString(),style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                    ),),
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
