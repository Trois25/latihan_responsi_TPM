import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DetailWeap extends StatefulWidget {
  final String weapname;
  const DetailWeap({Key? key, required this.weapname}) : super(key: key);

  @override
  State<DetailWeap> createState() => _DetailWeapState();
}

class _DetailWeapState extends State<DetailWeap> {

  late String stringResponsedetail;
  Map? mapResponsedetail;

  Future apicallWeapDetail()async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.genshin.dev/weapons/"+ widget.weapname));
    if(response.statusCode == 200){
      setState(() {
        stringResponsedetail = response.body;
        mapResponsedetail = json.decode(response.body);
      });
    }
  }

  Future<void> storeShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('last', widget.weapname);
    prefs.setString('code', "weapons");
  }

    @override

  void initState(){
    apicallWeapDetail();
    storeShared();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail " + widget.weapname),
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
                          Image.network("https://api.genshin.dev/weapons/"+ widget.weapname+"/icon",height:250,fit: BoxFit.fill,),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.weapname,style: TextStyle(
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
                        ],
                      ),
                    ],
                  )
              ),
            ],
          )
      ),
    );
  }
}
