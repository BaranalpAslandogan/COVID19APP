import 'package:covid19app/app/repo/data.dart';
import 'package:covid19app/app/repo/tum_vaka_veriler.dart';
import 'package:covid19app/app/servis/api.dart';
import 'package:covid19app/app/servis/api_servis.dart';
import 'package:covid19app/ulkeverileri.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  void initState() {
    super.initState();
    _veriGetir();
  }
  //TumVakaVerileri _dataRepo;
  String _token = '';
  var _olum,_vaka,_iyilesen;
  var _turkiyeVaka,_turkiyeOlum,_turkiyeIyilesen;

  Future<void> _veriGetir() async {
    final apiServis = APIServis(api:API.sandbox());
    final token= await apiServis.accesTokenGetir();

    final vakalar = await apiServis.TumVakaDataGetir(accessToken: token, tumVakalar: TumVakalar.vakalar);
    final olumler = await apiServis.TumVakaDataGetir(accessToken: token, tumVakalar: TumVakalar.olumler);
    final iyilesenler = await apiServis.TumVakaDataGetir(accessToken: token, tumVakalar: TumVakalar.iyilesenler);

    final turkiyeVaka = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.vakalar, ulke: Ulke.turkiye);
    final turkiyeOlum = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.olumler, ulke: Ulke.turkiye);
    final turkiyeIyilesen = await apiServis.UlkeyeGoreVeriGetir(accessToken: token, tumVakalar: TumVakalar.iyilesenler, ulke: Ulke.turkiye);
    
    setState(() {
      _token=token;
      _vaka = vakalar;
      _olum = olumler;
      _iyilesen = iyilesenler;

      _turkiyeVaka=turkiyeVaka;
      _turkiyeOlum=turkiyeOlum;
      _turkiyeIyilesen=turkiyeIyilesen;
    });

    /*final dataRepo = Provider.of<DataRepo>(context);
    final vakaVeri = await dataRepo.tumVakalarVeriGetir();
    setState(() {
    });*/
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Koronavirus Uygulaması"),
      ),
      body: RefreshIndicator(
        onRefresh: _veriGetir,
        child : Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50,),
            Text(
              'Token',
            ),
            Text(
              '$_token',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 50,),
            Text(
              'Toplam Vaka',
            ),
           _vaka!=null ? Text(
              '$_vaka',
              style: TextStyle(fontSize: 30, color: Colors.orangeAccent),
            ) : Text(""),
            SizedBox(height: 20,),
            Text(
              'Ölümler',
            ),
            _olum!=null ? Text(
              '$_olum',
              style: TextStyle(fontSize: 30, color: Colors.redAccent),
            ) : Text(""),
            SizedBox(height: 20,),
            Text(
              'İyileşenler',
            ),
            _iyilesen!=null ? Text(
              '$_iyilesen',
              style: TextStyle(fontSize: 30, color: Colors.greenAccent),
            ) : Text(""),
            SizedBox(height: 30,),
            IconButton(
              icon: Icon(Icons.refresh),
              color: Colors.teal,
              onPressed: _veriGetir,
            ),

            FlatButton(onPressed:(){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UlkeBazliVeriCek()),
            );
            } ,
            child: Text("Ülke bazında Veri Getir!")),
          ],
        ),
      ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
