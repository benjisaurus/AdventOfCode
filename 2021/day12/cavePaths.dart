import 'dart:io';

void main() async {
    final conns = await getInput("sample.txt");
    print('Contents: ${conns}');
}

Future<Map<String,Set<String>>> getInput(filename) async {
  final file = File(filename);
  final lines = await file.readAsString();
  var conns = Map<String,Set<String>>();
  conns["start"] = Set();
  lines.split("\n")
    .map((line) => line.split("-"))
    .forEach((pair) {
      var p1,p2 = pair;
      if(conns.containsKey(p1)) {
        p2.forEach((e) {
          conns[p1].add(e);
        });
      } else {
        conns[p1] = Set<String>();
      }
    });
  
  return conns;
}