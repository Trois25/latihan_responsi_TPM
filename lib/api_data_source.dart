import 'base_network.dart';

class ApiDataSource{
  static ApiDataSource instance = ApiDataSource();

  //////////////////////////////////////////////////////////////////////////////
  //get characters name
  Future<Map<String, dynamic>> loadCharacters(){
    return BaseNetwork.get("characters");
  }

  //get characters image
  Future<Map<String, dynamic>> loadCharactersImage(String charaname){
    String name = charaname.toString();
    return BaseNetwork.get("characters/$name/list");
  }

  //get characters gacha splash
  Future<Map<String, dynamic>> loadCharactersPotrait(String charaname){
    String name = charaname.toString();
    return BaseNetwork.get("characters/$name/gacha-splash");
  }

  //get characters gacha splash
  Future<Map<String, dynamic>> loadCharactersgachaSplash(String charaname){
    String name = charaname.toString();
    return BaseNetwork.get("characters/$name/gacha-splash");
  }

  //get characters talent
  Future<Map<String, dynamic>> loadCharactersTalent(String charaname, String tipe){
    String name = charaname.toString();
    String tipetalent = tipe.toString();
    return BaseNetwork.get("characters/$name/telent-$tipetalent");
  }

////////////////////////////////////////////////////////////////////////////////

  //get weapons name
  Future<Map<String, dynamic>> loadWeapons(){
    return BaseNetwork.get("weapons");
  }

  //get weapons image
  Future<Map<String, dynamic>> loadWeaponsImage(String weapname){
    String name = weapname.toString();
    return BaseNetwork.get("weapons/$name/list");
  }

////////////////////////////////////////////////////////////////////////////////

//get nation icon
  Future<Map<String, dynamic>> loadNationsIcon(String nationname){
    String name = nationname.toString();
    return BaseNetwork.get("nations/$name/icon");
  }

  //get elements icon
  Future<Map<String, dynamic>> loadElementsIcon(String elemname){
    String name = elemname.toString();
    return BaseNetwork.get("elements/$name/icon");
  }

}