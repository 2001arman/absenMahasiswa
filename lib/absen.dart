import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

TextEditingController _controllerNIM = TextEditingController();
TextEditingController _controllerNama = TextEditingController();
_hapus() {
  _controllerNIM.text = '';
  _controllerNama.text = '';
}

class PageAbsen extends StatefulWidget {
  @override
  _PageAbsenState createState() => _PageAbsenState();
}

class _PageAbsenState extends State<PageAbsen> {
  Future<List> getData() async {
    final response = await http.get("http://localhost/db.mahasiswa/getdata.php");
    return json.decode(response.body);
  }

  void addData() {
    var url = "http://localhost/db.mahasiswa/adddata.php";
    http.post(url,
        body: {"nim": _controllerNIM.text, "namamhs": _controllerNama.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.cyan[700],
          title: Text("Informatika E 2019"),
        ),
        body: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 8 / 10,
                        margin: EdgeInsets.only(top: 20, bottom: 10),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              prefixIcon: Icon(Icons.dialpad),
                              labelText: "NIM"),
                          controller: _controllerNIM,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: MediaQuery.of(context).size.width * 8 / 10,
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              prefixIcon: Icon(Icons.person),
                              labelText: "Nama Lengkap"),
                          onChanged: (value) {
                            setState(() {});
                          },
                          controller: _controllerNama,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          addData();
                          _hapus();
                          setState(() {});
                        },
                        child: Text("Kirim")),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.cyan[200]),
                  child: Column(children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                              color: Colors.cyan[400],
                              border: Border(
                                  right: BorderSide(color: Colors.black),
                                  bottom: BorderSide(color: Colors.black))),
                          child: Text("NIM",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width / 1.34,
                          decoration: BoxDecoration(
                              color: Colors.cyan[400],
                              border: Border(
                                  bottom: BorderSide(color: Colors.black))),
                          child: Text(
                            "Nama Mahasiswa",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder<List>(
                      future: getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);

                        return snapshot.hasData
                            ? new Data(
                                list: snapshot.data,
                              )
                            : new Center(
                                child: new CircularProgressIndicator(),
                              );
                      },
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ));
  }
}

class Data extends StatefulWidget {
  final List list;
  int index;
  Data({this.list, this.index});
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: widget.list == null ? 0 : widget.list.length,
          itemBuilder: (context, i) {
            return Container(
              decoration: BoxDecoration(color: Colors.cyan[200]),
              child: Row(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 4,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(color: Colors.black),
                              bottom: BorderSide(color: Colors.black))),
                      child: Text(widget.list[i]['nim'])),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black))),
                        child: Text(widget.list[i]['nama_mhs'])),
                  ),
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                content: new Text(
                                    "Are You sure want to delete '${widget.list[i]['nama_mhs']}'"),
                                actions: <Widget>[
                                  new RaisedButton(
                                    child: new Text(
                                      "OK DELETE!",
                                      style: new TextStyle(color: Colors.black),
                                    ),
                                    color: Colors.red,
                                    onPressed: () {
                                      var url =
                                          "http://localhost/db.mahasiswa/deletedata.php";
                                      http.post(url,
                                          body: {'id': widget.list[i]['id']});
                                      Navigator.push(context, new MaterialPageRoute(builder: (context) => PageAbsen()));
                                      setState(() {});
                                    },
                                  ),
                                  new RaisedButton(
                                    child: new Text("CANCEL",
                                        style:
                                            new TextStyle(color: Colors.black)),
                                    color: Colors.green,
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              );
                            });
                      }),
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(child: Text("Ubah Data")),
                                content: Container(
                                  height: 150,
                                  width:
                                      MediaQuery.of(context).size.width * 1.5,
                                  child: Column(
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            prefixIcon: Icon(Icons.dialpad),
                                            labelText: "NIM"),
                                        controller: _controllerNIM =
                                            new TextEditingController(
                                                text: widget.list[i]['nim']),
                                      ),
                                      SizedBox(height: 20),
                                      TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            prefixIcon: Icon(Icons.person),
                                            labelText: "Nama Lengkap"),
                                        controller: _controllerNama =
                                            new TextEditingController(
                                                text: widget.list[i]
                                                    ['nama_mhs']),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        child: Text('Batal'),
                                        onPressed: () {
                                          _hapus();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Perbarui Data'),
                                        onPressed: () {
                                          var url =
                                              "http://localhost/db.mahasiswa/editdata.php";
                                          http.post(url, body: {
                                            "id": widget.list[i]['id'],
                                            "nim": _controllerNIM.text,
                                            "namamhs": _controllerNama.text,
                                          });
                                          _hapus();
                                          setState(() {});
                                          Navigator.push(context, new MaterialPageRoute(builder: (context) => PageAbsen()));
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            });
                      })
                ],
              ),
            );
          }),
    );
  }
}
