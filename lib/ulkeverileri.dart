
import 'package:covid19app/ulketablar.dart';
import 'package:flutter/material.dart';

import 'app/servis/api.dart';
import 'app/servis/api_servis.dart';

class UlkeBazliVeriCek extends StatefulWidget {
  @override
  _UlkeBazliVeriCekState createState() => _UlkeBazliVeriCekState();
}

class _UlkeBazliVeriCekState extends State<UlkeBazliVeriCek> {

  @override
  void initState() {
    super.initState();
    ulkeVeriGetir();
  }

  String _token = '';
  var _turkiyeVaka,_turkiyeOlum,_turkiyeIyilesen;
  var _fransaVaka,_fransaOlum,_fransaIyilesen;
  var _nepalVaka,_nepalOlum,_nepalIyilesen;
  var _vietnamVaka,_vietnamOlum,_vietnamIyilesen;
  var _ispanyaVaka,_ispanyaOlum,_ispanyaIyilesen;

  Future<void> ulkeVeriGetir() async{

    final apiServis = APIServis(api:API.sandbox());
    final token= await apiServis.accesTokenGetir();

    final turkiyeVaka = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.vakalar, ulke: Ulke.turkiye);
    final turkiyeOlum = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.olumler, ulke: Ulke.turkiye);
    final turkiyeIyilesen = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.iyilesenler, ulke: Ulke.turkiye);

    final fransaVaka = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.vakalar, ulke: Ulke.fransa);
    final fransaOlum = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.olumler, ulke: Ulke.fransa);
    final fransaIyilesen = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.iyilesenler, ulke: Ulke.fransa);

    final nepalVaka = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.vakalar, ulke: Ulke.nepal);
    final nepalOlum = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.olumler, ulke: Ulke.nepal);
    final nepalIyilesen = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.iyilesenler, ulke: Ulke.nepal);

    final vietnamVaka = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.vakalar, ulke: Ulke.vietnam);
    final vietnamOlum = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.olumler, ulke: Ulke.vietnam);
    final vietnamIyilesen = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.iyilesenler, ulke: Ulke.vietnam);

    final ispanyaVaka = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.vakalar, ulke: Ulke.ispanya);
    final ispanyaOlum = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.olumler, ulke: Ulke.ispanya);
    final ispanyaIyilesen = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.iyilesenler, ulke: Ulke.ispanya);
    
    setState(() {
      _token=token;
      _turkiyeVaka=turkiyeVaka; _turkiyeOlum=turkiyeOlum; _turkiyeIyilesen=turkiyeIyilesen;
      _fransaVaka=fransaVaka; _fransaOlum=fransaOlum; _fransaIyilesen=fransaIyilesen;
      _nepalVaka=nepalVaka; _nepalOlum=nepalOlum; _nepalIyilesen=nepalIyilesen;
      _vietnamVaka=vietnamVaka; _vietnamOlum=vietnamOlum; _vietnamIyilesen=vietnamIyilesen;
      _ispanyaVaka=ispanyaVaka; _ispanyaOlum=ispanyaOlum; _ispanyaIyilesen=ispanyaIyilesen;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Koronavirus Uygulaması"),
      ),
      body: RefreshIndicator(
        onRefresh: ulkeVeriGetir,
        child: ListView(children: <Widget>[
          Column(
              children:<Widget>[
                UlkeTablar(
                  ulkeBaslik: "Türkiye",
                  ulkeVaka:_turkiyeVaka ,
                  ulkeOlum: _turkiyeOlum,
                  ulkeIyilesen: _turkiyeIyilesen,
                ),
                UlkeTablar(
                  ulkeBaslik: "Nepal",
                  ulkeVaka:_nepalVaka ,
                  ulkeOlum: _nepalOlum,
                  ulkeIyilesen: _nepalIyilesen,
                ),
                UlkeTablar(
                  ulkeBaslik: "Fransa",
                  ulkeVaka:_fransaVaka ,
                  ulkeOlum: _fransaOlum,
                  ulkeIyilesen: _fransaIyilesen,
                ),
                UlkeTablar(
                  ulkeBaslik: "Vietnam",
                  ulkeVaka:_vietnamVaka ,
                  ulkeOlum: _vietnamOlum,
                  ulkeIyilesen: _vietnamIyilesen,
                ),
                UlkeTablar(
                  ulkeBaslik: "İspanya",
                  ulkeVaka:_ispanyaVaka ,
                  ulkeOlum: _ispanyaOlum,
                  ulkeIyilesen: _ispanyaIyilesen,
                ),
              ]
          )
        ],),
      )
    );
  }
}