import 'package:boykiloindeks/hesap.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ikon_icerik.dart';
import 'reuseble_card.dart';
import 'sabitler.dart';
import 'sonuc.dart';
import 'hesap.dart';
import 'package:boykiloindeks/Kalori_Sonuc.dart';

enum Cinsiyet{
  erkek,
  kadin
}

class VeriGiris extends StatefulWidget {
  @override
  _VeriGirisState createState() => _VeriGirisState();
}

class _VeriGirisState extends State<VeriGiris> {
  Color erkekKartRenk = kInactiveKartRenk;
  Color kadinKartRenk = kInactiveKartRenk;

  Cinsiyet? seciliCinsiyet;
  int boy = 180;
  int kilo = 60;
  int yas = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BKI HESAPLAMA'),
          backgroundColor: Color(0xFF0A0D22),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Reusable_Card(
                        cnstyTiklama: (){
                          //setState(() {
                            seciliCinsiyet= Cinsiyet.erkek;
                        //}
                          //);
                        },
                        renk: seciliCinsiyet == Cinsiyet.erkek ? kAktifKartRengi : kInactiveKartRenk,
                        CardChild: IkonIcerik(ikon: FontAwesomeIcons.mars,
                        text: 'ERKEK',
                        ),
                  )),
                  Expanded(child: Reusable_Card(
                    cnstyTiklama: (){
                      //setState(() {
                        seciliCinsiyet= Cinsiyet.kadin;
                      //});
                    },
                    renk: seciliCinsiyet == Cinsiyet.kadin ? kAktifKartRengi : kInactiveKartRenk,
                    CardChild: IkonIcerik(ikon: FontAwesomeIcons.venus,
                      text: 'KADIN',
                    ),
                  ))
                ],
              ),
            ),
            Expanded(
                child: Reusable_Card(renk: kAktifKartRengi,
                  CardChild: (Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'BOY',style: kEtiketStili,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,  // CM Y?? A??A??IYA ??EKT??K !
                        children: <Widget>[
                          Text(
                              boy.toString(), style: kSayiStili
                          ),
                          Text('CM',style: kEtiketStili,),
                        ],
                      ),
                      Slider(
                        value: boy.toDouble(),
                        min: 120,
                        max: 220,
                        activeColor: Color(0xFFEB1555),
                        inactiveColor: Color(0xFF8D8E98),
                        onChanged: (double yeniBoyDeger){
                          //setState(() {
                            boy = yeniBoyDeger.round();
                          //});
                        },
                      ),
                    ],
                  )
                  ), cnstyTiklama: (){},
                )), // SL??DER B??L??M??

            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: Reusable_Card
                    (renk: kAktifKartRengi,
                    CardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'K??LO', style: kEtiketStili,
                        ),
                        Text(
                          kilo.toString(), style: kSayiStili,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            yuvarlakIkonButon(
                             ikon: FontAwesomeIcons.minus,
                              tiklama: (){
                               //setState(() {
                                 kilo--;
                               //});
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            yuvarlakIkonButon(
                              ikon: FontAwesomeIcons.plus,
                              tiklama: (){
                                //setState(() {
                                  kilo++;
                                //});
                              },
                            )
                          ],
                        )
                      ],
                    ), cnstyTiklama: (){},
                  )
                  ),
                  Expanded(child: Reusable_Card(
                    renk: kAktifKartRengi,
                    CardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('YA??',style: kEtiketStili,),
                        Text(yas.toString(),style: kSayiStili,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            yuvarlakIkonButon(
                              ikon: FontAwesomeIcons.minus,
                              tiklama: (){
                                //setState(() {
                                  yas--;
                                //});
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            yuvarlakIkonButon(
                              ikon: FontAwesomeIcons.plus,
                              tiklama: (){
                                //setState(() {
                                  yas++;
                                //});
                              },
                            ),
                          ],
                        ),
                      ],
                    ), cnstyTiklama: (){},
                  ))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                BKIHesap calc = BKIHesap(bireyBoy: boy,bireyKilo: kilo);
                Navigator.push(context,MaterialPageRoute(builder: (context) =>  SonucSayfasi
                  (bkiSinif: calc.bkihesapla(),
                    bkiDeger: calc.sonucSiniflama(),
                  bkiAciklama: calc.sonucAciklamasi(),

                ),),);},
              child: Container(
                child: Center(child: Text('HESAPLA',style: kBuyukButon,)),
                color: kAltContainerRenk,
                height: kAltButonYukseklik,
                width: double.infinity,
                margin: EdgeInsets.only(top: 10.0),
              ),
            )
          ],
        ));
  }
}

class yuvarlakIkonButon extends StatelessWidget {
  yuvarlakIkonButon({required this.ikon,required this.tiklama});
  final IconData ikon;
  final Function tiklama;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(ikon),
      onPressed: tiklama(),
      elevation: 6.0,
      constraints:  BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}

