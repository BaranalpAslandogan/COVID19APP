import 'package:covid19app/app/repo/tum_vaka_veriler.dart';
import 'package:covid19app/app/servis/api.dart';
import 'package:covid19app/app/servis/api_servis.dart';
import 'package:flutter/material.dart';

class DataRepo{
  DataRepo({@required this.apiServis});
  final APIServis apiServis;
  String _token;

  Future<APIServis> vakaVeriGetir (TumVakalar tumVakalar) async{
    try{
      _token = await apiServis.accesTokenGetir();
    } 
    catch(e){
      if(e.statusCode==401){
        _token = await apiServis.accesTokenGetir();
      }
      else{
        print("Repo veri çağırma hata: $e");
      }
    }
  }

  Future<TumVakaVerileri> tumVakalarVeriGetir() async{
    /*try{
      final tumDeger = await Future.wait([
      apiServis.TumVakaDataGetir(accessToken: _token, tumVakalar: TumVakalar.vakalar),
      apiServis.TumVakaDataGetir(accessToken: _token, tumVakalar: TumVakalar.olumler),
      apiServis.TumVakaDataGetir(accessToken: _token, tumVakalar: TumVakalar.iyilesenler),
    ]);
    return TumVakaVerileri(
      deger: {
        TumVakalar.vakalar: tumDeger[0],
        TumVakalar.olumler: tumDeger[1],
        TumVakalar.iyilesenler: tumDeger[2],
      },
    );} 
    catch(e){
      print("Repo tüm veri çağırma Hata: $e");
    }*/
  }
}



