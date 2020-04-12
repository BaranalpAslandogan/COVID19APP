import 'dart:convert';
import 'package:covid19app/app/repo/tum_vaka_veriler.dart';
import 'package:covid19app/app/servis/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class APIServis{
  APIServis({@required this.api});
  final API api;

  Future<String> accesTokenGetir() async {
     final cevap =await http.post(
       api.tokenUri().toString(),
       headers: {'Authorization': 'Basic ${api.myKey}'},
     );

     try{
      if(cevap.statusCode==200){
        final data = json.decode(cevap.body); 
        final accessToken = data['access_token'];
        if(accessToken != null){
          return accessToken;
        }
      }
      throw cevap;
     }
     catch(e){
       print(e);
     }
  }

  Future<int> TumVakaDataGetir({@required String accessToken,@required TumVakalar tumVakalar,}) async {
    final uri = api.tumVakaUri(tumVakalar);
    final cevap = await http.get(
      uri.toString(),
      headers: {'Authorization':'Bearer $accessToken'},
    );

    if(cevap.statusCode == 200){
      final List<dynamic> data = json.decode(cevap.body);
      if(data.isNotEmpty){
        
        final Map<String, dynamic> tumVakaData = data[0];
        final String cevapJsonKey = _cevapJsonKey[tumVakalar]; 
        final int sonuc = tumVakaData[cevapJsonKey];

        
        if(sonuc!=null){
          return sonuc;
        }
      } 
    }
    print('Hata: $uri , Cevap: ${cevap.statusCode} ${cevap.reasonPhrase}');
    throw cevap;
  }

  Future<int> UlkeyeGoreVeriGetir({@required String accessToken, @required TumVakalar tumVakalar, @required Ulke ulke}) async{
    final ulkeUri = api.ulkeVakaUri(tumVakalar, ulke);
    final veriCek = await http.get(
      ulkeUri.toString(),
      headers: {'Authorization':'Bearer $accessToken'},
    );
    final List<dynamic> veri = json.decode(veriCek.body);
    if(veri.isNotEmpty){
      final Map<String, dynamic> tumVakaData = veri[0];
      final String cevapJsonKey = _cevapJsonKey[tumVakalar]; 
      final int sonuc = tumVakaData[cevapJsonKey];

      if(sonuc!=null){
        return sonuc;
      }
      else{
        print('Hata: $ulkeUri , Sonuç: ${veriCek.statusCode} ${veriCek.body}');
      }
    } 
  }

  static Map<TumVakalar, String> _cevapJsonKey = {
    TumVakalar.vakalar: 'cases',
    TumVakalar.olumler: 'data',
    TumVakalar.iyilesenler: 'data',
  };
  
}