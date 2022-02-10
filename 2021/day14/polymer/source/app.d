import std.stdio;
import std.file;
import core.runtime;
import std.array;
import std.algorithm;
import std.format;

string[string] parseRules(string input){
	string[string] rules;
	foreach(pair; map!(x => x.split(" -> "))(input.split("\n"))){
		rules[pair[0]] = pair[1];
	}
	return rules;
}

string ruleStep(string input, string[string] rules){
	auto newFormula = "";
	foreach(i; 0 .. (input.length) - 1){
		newFormula ~= input[i];
		auto idx = "";
		idx ~= input[i];
		idx ~= input[i + 1];
		newFormula ~= rules[idx];
	}
	newFormula ~= input[(input.length) - 1];
	return newFormula;
}

int[char] charCounts(string input){
	int[char] counts;
	foreach(i; 0 .. input.length){
		auto ch = input[i];
		if(ch in counts){
			counts[ch] += 1;
		} else {
			counts[ch] = 1;
		}
	}
	return counts;
}

int[string] initPairCounts(string[string] rules, string txt){
    int[string] pairCounts;
	foreach(pair; rules.keys){
		pairCounts[pair] = 0;
	}
	foreach(i; 0 .. (txt.length) - 1){
		char fst = txt[i];
		char snd = txt[i + 1];
		char mid = rules[format("%c%c", fst,snd)][0];
		//writefln("init pair counts %c %c %c", fst, mid, snd);
		pairCounts[format("%c%c", fst, mid)] += 1;

		pairCounts[format("%c%c", mid, snd)] += 1;
	}
	return pairCounts;
}

int[string] stepPairCounts(string[string] rules, int[string] counts){
	int[string] newCounts;
	foreach(k; rules.keys){ newCounts[k] = 0; }
	foreach(pair; counts.keys){
		auto fst = pair[0];
		auto snd = pair[1];
		auto mid = rules[pair][0];
		foreach(i; 0 .. counts[pair]){
			newCounts[format("%c%c", fst, mid)] += 1;
			newCounts[format("%c%c", mid, snd)] += 1;
		}
	}
	return newCounts;
}

int[char] countCharPairs(int[string] pairCounts){
	int[char] counts;
	foreach(pair; pairCounts.keys){
		auto count = pairCounts[pair];
		foreach(ch; pair){
			if(ch in counts){
			    counts[ch] += count;
		    } else {
			    counts[ch] = count;
		    }
		}
	}
	return counts;
}

void main()
{
	auto filename = core.runtime.Runtime.args[1];
	auto content = readText(filename).split("\n\n");
	auto tmplt = content[0];
	auto tmplt2 = content[0];
    auto rules = parseRules(content[1]);
	foreach(i; 0 .. 10){
		tmplt = ruleStep(tmplt, rules);
	}
	auto counts = (charCounts(tmplt)).values;
    writeln(counts.maxElement - counts.minElement);
	// auto pc = initPairCounts(rules, tmplt);
	// auto cnts = (countCharPairs(pc)).values;
	// writeln(cnts.maxElement - cnts.minElement);

	// Part 2
	auto pairCounts = initPairCounts(rules, tmplt2);
	foreach(i; 0 .. 40){
		writefln("iteration %d", i);
	    pairCounts = stepPairCounts(rules, pairCounts);
	}
	auto counts2 = (countCharPairs(pairCounts)).values;
	//writeln(pairCounts);
	writeln(counts2.maxElement - counts2.minElement);
}
