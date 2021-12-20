export function getInput(filename: string): string[] {
    return Deno.readTextFileSync(filename)
        .replaceAll(" |\n", " | ")
        .split("\n");
}

const segmentSections: {[key: number]: string[]} = {
    0: ["t","b","ru","rb","lu","lb"],
    1: ["ru","rb"],
    2: ["t","m","b","ru","lb"],
    3: ["t","m","b","ru","rb"],
    4: ["m","ru","rb","lu"],
    5: ["t","m","b","rb","lu"],
    6: ["t","m","b","rb","lu","lb"], 
    7: ["t","ru","rb"],
    8: ["t","m","b","ru","rb","lu","lb"],
    9: ["t","m","b","ru","rb","lu"]
};

let segmentCounts: {[key: number]: number} = {};

Object.keys(segmentSections).forEach( k => {
    let kNum = parseInt(k);
    segmentCounts[kNum] = segmentSections[kNum].length;
})

const input = getInput("sample.txt");

let currentPattern = input[0];

let [currentSegs,currentNums] = currentPattern.split(" | ");

let currentSegLetters: {[key: number]: string} = {};

currentSegs.split(" ").forEach( seg => {
    switch(seg.length) {
        case 2:
            currentSegLetters[1] = seg;
            break;
        case 3:
            currentSegLetters[7] = seg;
            break;
        case 4:
            currentSegLetters[4] = seg;
            break;
        case 7:
            currentSegLetters[8] = seg;
            break;
        default:
            break;
    }
});

let currentLetterCount: {[key: string]: number} = {};

for(let i = 0; i < currentSegs.length; i++) {
    let letter = currentSegs[i];
    if(letter != " "){
        if(Object.keys(currentLetterCount).includes(letter)){
            currentLetterCount[letter] += 1;
        } else {
            currentLetterCount[letter] = 1;
        }
    }
}

let individualSegs: {[key: string]: string} = {};

Object.keys(currentLetterCount).forEach( k => {
    switch(currentLetterCount[k]){
        case 4:
            individualSegs["lb"] = k;
            break;
        case 6:
            individualSegs["lu"] = k;
            break;
        case 9:
            individualSegs["rb"] = k;
            break;
        default:
            break;
    }
});

Object.keys(currentLetterCount).forEach( c => {
    switch(currentLetterCount[c]){
        case 7:
            if(currentSegLetters[4].includes(c)){
                individualSegs["m"] = c;
            } else {
                individualSegs["b"] = c;
            }
            break;
        case 8:
            if(currentSegLetters[4].includes(c)){
                individualSegs["ru"] = c;
            } else {
                individualSegs["t"] = c;
            }
            break;
        default:
            break;
    }
});

Object.keys(segmentSections).forEach( n => {
    let num = parseInt(n);
    let letters = "";
    segmentSections[num].forEach( s => {
        letters += individualSegs[s];
    });
    currentSegLetters[num] = letters;
});

export function findNumber(letters: string, currentSegLetters: {[key: number]:string}) {
    letters.split(" ").forEach( p => {
        let num = "";
        Object.keys(currentSegLetters).forEach( k => {
            if(p.length == currentSegLetters[parseInt(k)].length){

            }
        })
    })
}