import 'package:flutter/material.dart';
import '../api/kysely_api.dart';
import '../components/kysymys.dart';
import '../components/palaute.dart';

class Kyselynakyma extends StatefulWidget {
  @override
  KyselynakymaState createState() => KyselynakymaState();
}

class KyselynakymaState extends State {
  var kysymys;
  var vastattu = false;
  var vastausOikein = false;

  @override
  initState() {
    super.initState();
    haeKysymys();
  }

  haeKysymys() async {
    kysymys = await KyselyApi().haeKysymys();
    vastattu = false;

    paivita();
  }

  paivita() {
    setState(() {});
  }

  vastaaKysymykseen(kysymysId, vastausId) async {
    vastausOikein = await KyselyApi().lahetaVastaus(kysymysId, vastausId);
    vastattu = true;

    paivita();
  }

  @override
  Widget build(BuildContext context) {
    if (kysymys == null) {
      return Scaffold(body: Text('Kysymystä haetaan'));
    }

    Widget sisalto;
    if (!vastattu) {
      sisalto = Kysymys(kysymys, vastaaKysymykseen);
    } else {
      sisalto = Palaute(vastausOikein, haeKysymys);
    }

    return Scaffold(body: SafeArea(child: Center(child: sisalto)));
  }
}
