const connPairs = Deno.readTextFileSync("sample.txt")
    .split("\n")
    .map(p => p.split("-"));

let conns: {[key: string]: [string]} = {};

connPairs.map((p) => {
    const p1 = p[0];
    const p2 = p[1];
    if(!(Object.keys(conns).includes(p1))){
        conns[p1] = [p2];
    } else {
        conns[p1].push(p2);
    }
    if(!(Object.keys(conns).includes(p2))){
        conns[p2] = [p1];
    } else {
        conns[p2].push(p1);
    }
});

let paths = [["start"]];

function enumeratePaths(complete: [[string]], toCheck: [[string]], conns: {[key: string]: [string]}) {
    if(toCheck.length < 1) { return complete; }
    for(let pathList = toCheck.pop(); toCheck.length > 0; pathList = toCheck.pop()) {
        let current = pathList[pathList.length - 1];
        conns.array.forEach(cave => {
            if((cave == cave.toUpperCase()) || (!(pathList.includes(cave)))){
                toCheck.push(pathList.push(cave));
            }
        });
    })
}

//console.log(connPairs);
console.log(conns);