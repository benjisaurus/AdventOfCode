export function getFour(): number { return 4; }

export function getInput(filename: string): string[] {
    return Deno.readTextFileSync(filename).split("\n\n");
}

export function parseNums(input: string): number[] {
    return input.split(",").map(x => parseInt(x));
}

export function parseBoard(input: string): number[][] {
    return input.split("\n")
        .map(x => x.trim()
        .split(/\s+/)
        .map(n => parseInt(n))
    );
}

export function parseBoards(input: string[]): number[][][] {
    return input.map(x => parseBoard(x));
}

export function initBoardMarks(cols: number, rows: number, amount: number): number[][][] {
    let markBoards: number[][][] = [];
    for(let i = 0; i < amount; i++) {
        let newBoard: number [][] = [];
        for(let j = 0; j < rows; j++) {
            let newRow: number[] = [];
            for(let k = 0; k < cols; k++) {
                newRow.push(0);
            }
            newBoard.push(newRow);
        }
        markBoards.push(newBoard);
    }
    return markBoards;
}