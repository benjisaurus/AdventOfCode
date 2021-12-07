export function getFive(): number {
    return 5;
}

export function getInput(filename: string): number[][][] {
    return Deno.readTextFileSync(filename)
    .split("\n")
    .map(x => x.split(" -> ")
        .map(y => y.split(",")
            .map(z => parseInt(z))));
}

export function getMaxs(coord: number[][][]): number[] {
    let maxX = 0;
    let maxY = 0;
    coord.forEach(s => {
        s.forEach(p => {
            let x = p[0];
            let y = p[1];
            if(x > maxX) { maxX = x; }
            if(y > maxY) { maxY = y; }
        })
    });
    return [maxX + 1,maxY + 1];
}

export function initGrid(nums: number[]): number[][] {
    let maxX = nums[0];
    let maxY = nums[1];
    if(maxX > maxY) {
        maxY = maxX;
    } else {
        maxX = maxY;
    }
    let grid: number[][] = [];
    for(let x = 0; x < maxX; x++) {
        let newRow: number[] = [];
        for(let y = 0; y < maxY; y++) {
            newRow.push(0);
        }
        grid.push(newRow);
    }
    return grid;
}

export function markGrid(grid: number[][], coords: number [][][]) {
    const hor = coords.filter(coord => coord[0][1] == coord[1][1]);
    const vert = coords.filter(coord => coord[0][0] == coord[1][0]);
    hor.forEach(pair => {
        //console.log("horizontal");
        //console.log(pair);
        const y = pair[0][1];
        let startX = 0;
        let endX = 0;
        if(pair[0][0] > pair[1][0]){
            startX = pair[1][0];
            endX = pair[0][0];
        } else {
            startX = pair[0][0];
            endX = pair[1][0];
        }
        for(let x = startX; x < endX + 1; x++){
            grid[y][x] += 1;
        }
    });
    vert.forEach(pair => {
        //console.log("verticle");
        //console.log(pair);
        const x = pair[0][0];
        let startY = 0;
        let endY = 0;
        if(pair[0][1] > pair[1][1]){
            startY = pair[1][1];
            endY = pair[0][1];
        } else {
            startY = pair[0][1];
            endY = pair[1][1];
        }
        for(let y = startY; y < endY + 1; y++){
            grid[y][x] += 1;
        }
    });
}

export function diagNums(startNum: number, endNum: number): number[] {
    let numList: number[] = [];
    let dir = 1;
    if(startNum > endNum) {
        dir = -1;
    }
    switch(dir) {
        case 1:
            for(let i = startNum; i <= endNum; i++){
                numList.push(i);
            }
            break;
        case -1:
            for(let i = startNum; i >= endNum; i--){
                numList.push(i);
            }
            break;
    }
    return numList;
}

export function markDiagonal(grid: number[][], coords: number[][][]) {
    const diag = coords.filter(c => c[0][1] != c[1][1])
        .filter(c2 => c2[0][0] != c2[1][0]);
    diag.forEach(pair => {
        const xList = diagNums(pair[0][0], pair[1][0]);
        const yList = diagNums(pair[0][1], pair[1][1]);
        for(let i = 0; i < xList.length; i++) {
            grid[yList[i]][xList[i]] += 1;
        }
    })
}

export function countGrid(grid: number[][]): number {
    let count = 0;
    grid.forEach(row => {
        row.forEach(c => {
            if(c > 1) {
                count += 1;
            }
        })
    })
    return count;
}