import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator app ',
    theme: ThemeData(
      // ignore: deprecated_member_use
      accentColor: Colors.blueAccent,
    ),
    home: Siform(),
  ));
}

class Siform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIformState();
  }
}

class _SIformState extends State<Siform> {
  var _formKey = GlobalKey<FormState>();
  var currency = ['Rupees', 'Dollars', 'Pounds'];
  var displytext = '';
  var currentcurrency = 'Rupees';
  TextEditingController principlecontroler = TextEditingController();
  TextEditingController roicontroler = TextEditingController();
  TextEditingController termcontroler = TextEditingController();
  TextEditingController displytextcnt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SI Calculator'),
          titleTextStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                GetImage(),
                TextFormField(
                    controller: principlecontroler,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'pls enter valid amount';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Principle',
                      hintText: 'Enter Principle e.g. 12000',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    )),
                const SizedBox(height: 10),
                TextFormField(
                    controller: roicontroler,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'pls enter valid rate of interest';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Rate Of Interest',
                      hintText: 'In Percent',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    )),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: termcontroler,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'pls enter valid term';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'In Years',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                    )),
                    const SizedBox(width: 10),
                    Expanded(
                        child: DropdownButton<String>(
                      items: currency.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: currentcurrency,
                      onChanged: (newvalue) {
                        setvalue(newvalue);
                      },
                    )),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,
                            onPrimary: Colors.white,
                            elevation: 6),
                        child: const Text('Calculate',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              displytext = calculate();
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: ElevatedButton(
                        child: const Text('Reset'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.indigo,
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                            elevation: 6),
                        onPressed: () {
                          setState(() {
                            reset();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: EdgeInsets.all(7),
                      height:50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(displytext,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize:15,color:Colors.brown),textAlign: TextAlign.center,),
                    ))
              ],
            ),
          ),
        ));
  }

  Widget GetImage() {
    AssetImage assetImage =
        const AssetImage('assets/images/undraw_Success_factors_re_ce93.png');
    Image image = Image(
      image: assetImage,
      width: 350,
      height: 350,
    );
    return Container(
      child: image,
      padding: EdgeInsets.only(bottom: 10),
    );
  }

  void setvalue(String? newvalue) {
    setState(() {
      currentcurrency = newvalue!;
    });
  }

  String calculate() {
    double principle = double.parse(principlecontroler.text);
    double roi = double.parse(roicontroler.text);
    double term = double.parse(termcontroler.text);
    double totalamount = principle + (principle * roi * term) / 100;
    String result =
        "After $term years your investment will be  $totalamount $currentcurrency";
    return result;
  }

  void reset() {
    principlecontroler.text = '';
    roicontroler.text = '';
    termcontroler.text = '';
    currentcurrency = currency[0];
    displytextcnt.text = " ";
  }
}
