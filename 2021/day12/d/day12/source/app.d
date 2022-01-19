import std.stdio;
import std.file;
import std.array;
import std.algorithm;
import std.uni;

string[][string] getInput(string filename){
    auto pairs = map!(l => l.split("-"))(readText(filename).split("\n"));
	string[][string] conns;
	foreach(pair; pairs) {
		auto fst = pair[0];
		auto snd = pair[1];
		if(fst in conns) {
			if(!conns[fst].canFind(snd)) {
				conns[fst] ~= [snd];
			}
		} else {
			conns[fst] = [snd];
		}
		if(snd in conns) {
			if(!conns[snd].canFind(fst)) {
				conns[snd] ~= [fst];
			}
		} else {
			conns[snd] = [fst];
		}
	}
	return conns;
}

int maxLowerCount(string[] nodes){
	int[string] counts;
	foreach(node; nodes){
		if(node == node.toLower){
			if(node in counts){
				counts[node] += 1;
			} else {
				counts[node] = 1;
			}
		}
	}
	return maxElement(counts.values);
}

string[][] getPaths(string[][] toCheck,string[][] complete,string[][string] conns) {
	//writeln(toCheck);
	//writeln(complete);
    if(toCheck.length == 0){
		return complete;
	}
	auto check = toCheck[0];
	auto last = check[(check.length) - 1];
	foreach(node; conns[last]){
		if((node != "start") && ((node == node.toUpper) || (!check.canFind(node))
		 || (maxLowerCount(check) == 1))){
			if(node == "end") {
			    complete ~= check ~ [node];
		    } else {
		        toCheck ~= check ~ [node];
			}
		}
	}
	//writefln("toCheck length: %d", toCheck.length);
	//writefln("complete length: %d", complete.length);
	return getPaths(toCheck[1 .. $], complete, conns);
}

void main()
{
	auto conns = getInput("input.txt");
	//writeln(conns);
	auto paths = getPaths([["start"]], [], conns);
	writeln(paths.length);
}
