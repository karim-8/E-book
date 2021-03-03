/*
Copyright (c) 2021 Razeware LLC

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or
sell copies of the Software, and to permit persons to whom
the Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

Notwithstanding the foregoing, you may not use, copy, modify,
merge, publish, distribute, sublicense, create a derivative work,
and/or sell copies of the Software in any work that is designed,
intended, or marketed for pedagogical or instructional purposes
related to programming, coding, application development, or
information technology. Permission for such use, copying,
modification, merger, publication, distribution, sublicensing,
creation of derivative works, or sale is expressly withheld.

This project and source code may use libraries or frameworks
that are released under various Open-Source licenses. Use of
those libraries and frameworks are governed by their own
individual licenses.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
 */

import 'package:ebook/models/article_model.dart';
import 'package:ebook/utilis/constants.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: Constants.appTitle),
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
  var _pageNumber = 0;
  var _changeColor = true;
  var _rotate = 0;
  List<Offset> _points = <Offset>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: _changeColor ? Colors.brown : Colors.grey,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.rotate_left,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _rotate < 3 ? _rotate++ : _rotate = 0;
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: _changeColor ? Colors.white : Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                coverImageView(),
                bookTopic(),
                changePageView(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: new Container(
          color: _changeColor ? Colors.white : Colors.grey,
          height: 40.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${_pageNumber + 1}",
                style: TextStyle(color: Colors.black, fontSize: 18),
              )
            ],
          ),
        ),
    );
  }

  Widget coverImageView() {
    return Container(
      height: 200,
      color: Colors.black,
      child: Image.asset(
        getTopicsList().image,
        fit: BoxFit.fill,
        height: 200,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget bookTopic() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        child: Column(
          children: [
            Center(
              child: Text(
                getTopicsList().topicHeader,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                getTopicsList().topicBody,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget changePageView() {
    return Expanded(
        flex: 2,
        child: Container(
          color: _changeColor ? Colors.white : Colors.grey,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "images/previous-arrow.png",
                    fit: BoxFit.fill,
                    height: 50,
                    width: 40,
                  ),
                  Image.asset(
                    "images/forward-arrow.png",
                    fit: BoxFit.fill,
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  ArticleModel getTopicsList() {
    final items = ArticleModel.getData();
    final location = items[_pageNumber];
    return location;
  }
}
