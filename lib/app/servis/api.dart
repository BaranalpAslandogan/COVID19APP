import 'package:covid19app/app/servis/api_key.dart';
import 'package:flutter/foundation.dart';

enum TumVakalar{
  vakalar,
  olumler,
  iyilesenler,
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

  static Map<TumVakalar, String> _gecis = {
    TumVakalar.vakalar: 'cases',
    TumVakalar.olumler: 'deaths',
    TumVakalar.iyilesenler: 'recovered',
  };


}