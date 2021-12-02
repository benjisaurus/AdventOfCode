import { getTwo,getInput,moveSub } from "./two.ts"

const moves = getInput("input.txt");
const endPosition = moveSub(moves);
console.log(endPosition[0] * endPosition[1]);