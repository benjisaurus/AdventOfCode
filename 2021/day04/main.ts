import { 
    getInput,parseNums,parseBoard,initBoardMarks,
    markNumber,hasBingo,sumUnmarked,isBingo
} from "./four.ts";

const input = getInput("input.txt");
const nums = parseNums(input[0]);
const numBoards = input.slice(1).map(x => parseBoard(x));
const markBoards = initBoardMarks(numBoards[0].length, numBoards[0][0].length, numBoards.length);
for(let i = 0; i < nums.length; i ++) {
    let num = nums[i];
    markNumber(num, numBoards, markBoards);
    let bingo = hasBingo(markBoards);
    if(bingo > -1) {
        console.log("BINGO");
        const total = sumUnmarked(numBoards[bingo], markBoards[bingo]);
        console.log(num * total);
        break;
    }
}
console.log("Part 2");
const markBoards2 = initBoardMarks(numBoards[0].length, numBoards[0][0].length, numBoards.length);
let j = 0;
let hadBingo: number[] = [];
while(hadBingo.length < numBoards.length){
    let num = nums[j];
    //console.log(num);
    markNumber(num, numBoards, markBoards2);
    let bingos = markBoards2.map(b => isBingo(b));
    for(let j = 0; j < bingos.length; j++) {
        if(bingos[j] == 1 && (!(hadBingo.includes(j)))) {
            hadBingo.push(j);
        }
    }
    j += 1;
}
//console.log(hadBingo);
const lastBoard = hadBingo[hadBingo.length -1];
const lastNumCalled = nums[j-1];
//console.log(lastNumCalled);
const lastTotal = sumUnmarked(numBoards[lastBoard], markBoards2[lastBoard]);
console.log(lastTotal * lastNumCalled);

