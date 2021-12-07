import { getInput,getMaxs,initGrid,markGrid,countGrid,markDiagonal } from "./five.ts";

const input = getInput("input.txt");
const maxs = getMaxs(input);
let grid = initGrid(maxs);
markGrid(grid, input);
console.log(countGrid(grid));
markDiagonal(grid, input);
console.log(countGrid(grid));
