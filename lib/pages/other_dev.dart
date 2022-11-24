import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import './detail_tim.dart';

class OtherDevs extends StatefulWidget {
  const OtherDevs({super.key});

  @override
  State<OtherDevs> createState() => _OtherDevsState();
}

class _OtherDevsState extends State<OtherDevs> {
  List _mhs = [];

  // mengambil data dari json assets
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/tim.json');
    final data = json.decode(response);
    setState(() {
      _mhs = data['mahasiswa'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        title: const Text('Other Developers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _mhs.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _mhs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          key: ValueKey(_mhs[index]["id"]),
                          margin: const EdgeInsets.all(10),
                          color: Colors.greenAccent.shade100,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return DetailKelompok(
                                  name: _mhs[index]["name"],
                                  nim: _mhs[index]["nim"],
                                  desc: _mhs[index]["desc"],
                                );
                              }));
                            },
                            child: ListTile(
                              leading: Text(_mhs[index]["id"]),
                              title: Text(_mhs[index]["name"]),
                              subtitle: Text(_mhs[index]["nim"]),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
