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

export function markNumber(num: number, boards: number[][][], marks: number[][][]): number {
    let count = 0;
    const boardCount = boards.length;
    const rows = boards[0].length;
    const cols = boards[0][0].length;
    for(let b = 0; b < boardCount; b++) {
        for(let r = 0; r < rows; r++) {
            for(let c = 0; c < cols; c++) {
                if(boards[b][r][c] == num) {
                    marks[b][r][c] = 1;
                    count += 1;
                }
            }
        }
    }
    return count;
}

export function hasBingo(markBoards: number[][][]): number {
    const boards = markBoards.length;
    const rows = markBoards[0].length;
    const cols = markBoards[0][0].length;
    for(let b = 0; b < boards; b++) {
        for(let r = 0; r < rows; r++) {
            if(markBoards[b][r].reduce((x,y) => x + y) == 5) {
                return b;
            }
        }
        for(let c = 0; c < cols; c++) {
            let colSum = 0;
            for(let r2 = 0; r2 < rows; r2++) {
                colSum += markBoards[b][r2][c];
            }
            if(colSum == 5) {
                return b;
            }
        }
    }
    return -1;
}

export function isBingo(markBoard: number[][]): number {
    const rows = markBoard.length;
    const cols = markBoard[0].length;
    for(let r = 0; r < rows; r++) {
        if(markBoard[r].reduce((x,y) => x + y) == rows) {
            return 1;
        }
    }
    for(let c = 0; c < cols; c++) {
        let colSum = 0;
        for(let r2 = 0; r2 < rows; r2++) {
            colSum += markBoard[r2][c];
        }
        if(colSum == rows) {
            return 1;
        }
    }
    return 0;
}

export function sumUnmarked(board: number[][], markBoard: number[][]): number {
    let total = 0;
    for(let r = 0; r < board.length; r++) {
        for(let c = 0; c < board[r].length; c++) {
            if(markBoard[r][c] == 0) {
                total += board[r][c];
            }
        }
    }
    return total;
}