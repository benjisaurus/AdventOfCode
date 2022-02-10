import 'dart:io';

List<List<int>> getInput(String filename) {
  List<List<int>> contents = [];
    for(var line in File(filename).readAsLinesSync()){
      List<int> row = [];
      for(var i = 0; i < line.length; i++){
        row.add(
          int.parse(line[i]));
      }
      contents.add(row);
    }
  return contents;
}

List<List<int>> getNeighbors(int row, int col, int maxRow, int maxCol) {
  List<List<int>> neighbors = [];
  if(row < maxRow){ neighbors.add([row + 1, col]); }
  if(col < maxCol) { neighbors.add([row, col + 1]); }
  //if(row > 0){ neighbors.add([row - 1, col]); }
  //if(col > 0) { neighbors.add([row, col - 1]); }
  return neighbors;
}

int getPathRisk(List<List<int>> path, List<List<int>>grid) {
  var risk = 0;
  for(var node in path) {
    if(node != []) {
      risk += grid[node[0]][node[1]];
    }
  }
  return risk;
}

List<List<int>> getPath(List<List<int>> path, List<List<int>> grid) {
  var maxRow = grid.length - 1;
  var maxCol = grid[0].length - 1;
  var lastNode = path[path.length - 1];
  var row = lastNode[0];
  var col = lastNode[1];
  if(row == maxRow && col == maxCol){
    return path;
  } else {
    var neighbors = getNeighbors(row, col, maxRow, maxCol);
    if(neighbors.length == 1) {
      path.add(neighbors[0]);
      return getPath(path, grid);
    } else {
      List<List<int>> path1 = List.from(path);
      List<List<int>> path2 = List.from(path);
      path1.add(neighbors[0]);
      //print(path1);
      path2.add(neighbors[1]);
      //print(path2);
      var newPath1 = getPath(path1, grid);
      var newPath2 = getPath(path2, grid);
      if(getPathRisk(newPath1, grid) < getPathRisk(newPath2, grid)){
        return newPath1;
      } else {
        return newPath2;
      }
    }
  }
}

int search(List<int> current, List<List<int>> visited, List<List<int>> unvisited, List<List<int>> values, List<List<int>> scores){
  print(current);
  print(visited);
  var maxRow = values.length - 1;
  var maxCol = values[0].length - 1;
  var maxScore = 9 * maxRow * maxCol;
  if(current[0] == maxRow && current[1] == maxCol){
    for(var r in scores){
      print(r);
    }
    return scores[maxRow][maxCol];
  }
  var neighbors = getNeighbors(current[0], current[1], maxRow, maxCol);
  print(neighbors);
  neighbors.removeWhere((n) => visited.any((v) => v[0] == n[0] && v[1] == n[1]));
  print(neighbors);
  List<int> smallestNeighbor = [0,0];
  if(neighbors.length > 0){
    var smallestScore = maxScore;
    var currentScore = scores[current[0]][current[1]];
    smallestNeighbor = neighbors[0];
    for(var n in neighbors){
      var nRow = n[0];
      var nCol = n[1];
      var currentNScore = scores[nRow][nCol];
      var newNScore = values[nRow][nCol] + currentScore;
      if(newNScore < currentNScore){
        scores[nRow][nCol] = newNScore;
      }
      if(newNScore < smallestScore){
        smallestScore = newNScore;
        smallestNeighbor = [nRow, nCol];
      }
    }
  } else {
    findNewNeighbor:
    for(var i = 0; i <= maxRow; i++){
      for(var j = 0; j <= maxCol; j++){
        if(!(visited.any((v) => v[0] == i && v[1] == j))){
          smallestNeighbor = [i,j];
          break findNewNeighbor;
        }
      }
    }
  }
  visited.add(current);
  return search(smallestNeighbor, visited, unvisited, values, scores);
  //print(scores);
  //return 0;
}

void main() {
  var riskValues = getInput("sample.txt");
  var maxRow = riskValues.length - 1;
  var maxCol = riskValues[0].length - 1;
  List<List<int>> scores = [];
  List<List<int>> unvisited = [];
  for(var i = 0; i <= maxRow; i ++){
    List<int> newRow = [];
    for(var j = 0; j <= maxCol; j++){
      newRow.add(9 * maxRow * maxCol);
      unvisited.add([i,j]);
    }
    scores.add(newRow);
  }
  scores[0][0] = 0;
  //print(scores);
  //print(grid);
  //print(getNeighbors(2, 3, 3, 3));
  //print(getPathRisk([[8,8],[8,9],[9,9]], grid));
  //print(getPath([[0,0]],grid));
  //var path = getPath2([[0,0]], grid);
  //print(path);
  //print(getPathRisk(path, grid) - grid[0][0]);
  print(search([0,0], [], unvisited, riskValues, scores));
  // var lst1 = [[2,0],[1,1],[0,0]];
  // print(lst1);
  // var lst2 = [[0,1]];
  // lst1.removeWhere((e) => lst2.any((v) => v[0] == e[0] && v[1] == e[1]));
  // print(lst1);
}