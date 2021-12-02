import { getInput,moveSub,moveSubTwo } from "./two.ts"

const moves = getInput("input.txt");
const endPosition = moveSub(moves);
console.log(endPosition[0] * endPosition[1]);

const endPosition2 = moveSubTwo(moves);
console.log(endPosition2[0] * endPosition2[1]);