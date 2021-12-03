import { getInput,partOne,getOxygen,getCO2 } from "./three.ts";

const input = getInput("input.txt");
const power = partOne(input);
console.log(power);
const O2 = getOxygen(input);
const CO2 = getCO2(input);
console.log(O2 * CO2);