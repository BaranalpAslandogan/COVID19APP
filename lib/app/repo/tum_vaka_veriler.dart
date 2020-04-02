import 'package:covid19app/app/servis/api.dart';
import 'package:flutter/foundation.dart';

class TumVakaVerileri{
  TumVakaVerileri({@required this.deger});

  final Map<TumVakalar, VakalarVeri> deger;

  VakalarVeri get vakalar{
    return deger[TumVakalar.vakalar];
  }
  VakalarVeri get olumler{
    return deger[TumVakalar.olumler];
  }
  VakalarVeri get iyilesenler{
    return deger[TumVakalar.iyilesenler];
  }

  @override
  String toString() =>
      'vakalar: $vakalar, olumler: $olumler, iyilesenler: $iyilesenler';

}

class VakalarVeri {
  VakalarVeri({@required this.deger, this.tarih});
  final int deger;
  final DateTime tarih;
  @override
  String toString()=>'tarih: $tarih , deger: $deger';

}