import std.stdio;
import std.file;
import core.runtime;
import std.algorithm;
import std.array;
import std.conv;
import std.typecons;
import std.math.algebraic;

int[] getMaxCoords(int[][] pairs){
	auto maxX = 0;
    auto maxY = 0;
	foreach (pair; pairs)
	{
		if(pair[0] > maxX){ maxX = pair[0];}
		if(pair[1] > maxY){ maxY = pair[1];}
	}
	return [maxX, maxY];
}

int[][] parsePairs(string contents){
    int[][] pairs;
    auto tempPairs = map!(i => (i.split(",")))(contents.split("\n"));
	foreach(pair; tempPairs){
		pairs ~= [parse!int(pair[0]),parse!int(pair[1])];
	}
	return pairs;
}

Tuple!(string, int)[] parseFolds(string contents){
    Tuple!(string, int)[] folds;
    auto tempFolds = map!(f => f.split(" ")[2].split("="))(contents.split("\n"));
	foreach(fold; tempFolds){
		folds ~= tuple(fold[0], parse!int(fold[1]));
	}
	return folds;
}

int[][] foldY(int[][] grid, int foldOn){
	writefln("Fold Y, grid %d, %d, fold on %d", grid.length, grid[0].length, foldOn);
	int[][] newGrid;
	foreach(y; 0 .. foldOn + 1){
		int[] newRow;
	    foreach(x; 0 .. grid[0].length){
			newRow ~= grid[y][x];
		}
		newGrid ~= newRow;
	}

	// foreach(row; 0 .. foldOn + 1){
	// 	foreach(col; 0 .. newGrid[0].length){
	// 		auto val = grid[row][col] + grid[(grid.length) - (1 + row)][col];
	// 		newGrid[row][col] = val > 0 ? 1 : 0;
	// 	}
	// }

	foreach(y; foldOn .. grid.length){
		auto row = foldOn - abs(y - foldOn);
		auto foldRow = y;
		//writefln("row %d", row);
		//writefln("fold row %d", foldRow);
		foreach(col; 0 .. newGrid[0].length){
			//writefln("col %d", col);
			//auto val = grid[row][col] + grid[foldRow][col];
			//newGrid[row][col] = val > 0 ? 1 : 0;
			if(grid[y][col] == 1){
				auto foldY = foldOn - abs(y - foldOn);
				//writefln("foldY %d", foldY);
				newGrid[foldY][col] = 1;
			}
		}
	}

	return newGrid;
}

int[][] foldX(int[][] grid, int foldOn){

	writefln("Fold X, grid %d, %d, fold on %d", grid.length, grid[0].length, foldOn);
	int[][] newGrid;
	foreach(y; 0 .. grid.length){
		int[] newRow;
		foreach(x; 0 .. foldOn + 1){
			newRow ~= grid[y][x];
		}
		newGrid ~= newRow;
	}
	//writeln("foldX");
	// foreach(r; newGrid){
	// 	writeln(r);
	// }
	//writeln("foldX");
	//writeln("grid");
	//foreach(r; grid){ writeln(r); }
	//writeln("newGrid");
	//foreach(r; newGrid){ writeln(r); }

	foreach(row; 0 .. newGrid.length){
		//writefln("row %d", row);
		foreach(x; foldOn .. grid[0].length){
            //writefln("x %d", x);
		    auto foldX = foldOn - abs(x - foldOn);
		    //writefln("foldX %d", foldX);
			//auto col = foldOn - abs(x - foldOn);
			//auto foldCol = x;
			//writefln("col %d", col);
			//writefln("foldCol %d", foldCol);
			//auto val = grid[row][col] + grid[row][foldCol];
			//newGrid[row][col] = val > 0 ? 1 : 0;
			if(grid[row][x] == 1){
				newGrid[row][foldX] = 1;
			}
		}
	}

    //writeln("newGrid after");
	//foreach(r; newGrid){ writeln(r); }

	return newGrid;
}

void main()
{
	auto filename = core.runtime.Runtime.args[1];
	auto content = readText(filename).split("\n\n");
	int[][] pairs;
	Tuple!(string, int)[] folds;
	pairs = parsePairs(content[0]);
	folds = parseFolds(content[1]);
	auto maxCoord = getMaxCoords(pairs);
	int[][] grid;
	foreach(row; 0 .. maxCoord[1] + 1){
		int[] newRow;
		foreach(col; 0 .. maxCoord[0] + 1){
			newRow ~= 0;
		}
		grid ~= newRow;
	}
	foreach(pair; pairs){
		grid[pair[1]][pair[0]] = 1;
	}
	// foreach(row; grid){ writeln(row); }
	// auto foldYGrid = foldY(grid, folds[0][1]);
	// writeln("folded on y");
	// foreach(row; foldYGrid){ writeln(row); }
	// auto foldXGrid = foldX(foldYGrid, folds[1][1]);
	// writeln("folded on x");
	// foreach(row; foldXGrid){ writeln(row); }
    // writeln(sum(map!(sum)(foldXGrid)));
	string direction = "";
	int num = 0;
	foreach(fold; folds){
		//foreach(row; grid){ writeln(row); }
		writeln(sum(map!(sum)(grid)));
		direction = fold[0];
		num = fold[1];
		if(direction == "y"){
			grid = foldY(grid, num);
		} else {
			grid = foldX(grid, num);
		}
		writeln(sum(map!(sum)(grid)));
	}
	writeln(sum(map!(sum)(grid)));
	foreach(row; grid){ writeln(row); }
}
