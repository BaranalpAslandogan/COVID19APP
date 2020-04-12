import 'package:flutter/foundation.dart';
import 'package:covid19app/app/api_key.dart';

enum TumVakalar{
  vakalar,
  olumler,
  iyilesenler,
}

enum Ulke{
  nepal,
  turkiye,
  fransa,
  vietnam,
  ispanya,
}

class API{
  API({@required this.myKey});
  final String myKey;

  factory API.sandbox()=>API(myKey:APIKey.covid19key); 

  static final String host = 'apigw.nubentos.com';
  static final int port = 443;
  static final String baseGecis = 't/nubentos.com/ncovapi/1.0.0';

  Uri tokenUri()=>Uri(
    scheme: 'https', 
    host: host, 
    port: port, 
    path: 'token',
    queryParameters: {'grant_type':'client_credentials'},
  );

 
  Uri tumVakaUri(TumVakalar tumVakalar) => Uri(
    scheme: 'https',
    host: host,
    port: port,
    path: '$baseGecis/${_gecis[tumVakalar]}',
  );

  Uri ulkeVakaUri(TumVakalar tumVakalar, Ulke ulke) => Uri(
    scheme: 'https',
    host: host,
    port: port,
    path: '$baseGecis/${_gecis[tumVakalar]}',
    queryParameters: {'country': '${_ulke[ulke]}'},
  );

  static Map<TumVakalar, String> _gecis = {
    TumVakalar.vakalar: 'cases',
    TumVakalar.olumler: 'deaths',
    TumVakalar.iyilesenler: 'recovered',
  };

  static Map<Ulke, String> _ulke = {
    Ulke.fransa: 'France',
    Ulke.vietnam: 'Vietnam',
    Ulke.ispanya: 'Spain',
    Ulke.nepal: 'Nepal',
    Ulke.turkiye: 'Turkey',
  };
  //Deneme
}