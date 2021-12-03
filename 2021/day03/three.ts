export function getThree(): number { return 3; }

export function getInput(filename: string): string[] {
    const content = Deno.readTextFileSync(filename);
    return content.split("\n");
}

export function partOne(input: string[]): number {
    let gamma = "";
    let epsilon = "";
    const inputCount = input.length;
    const digits = input[0].length;
    for(let i = 0; i < digits; i++) {
        let ones = 0;
        let zeros = 0;
        for(let j = 0; j < inputCount; j++) {
            if(input[j][i] == "0"){
                zeros += 1;
            } else {
                ones += 1;
            }
        }
        if(ones > zeros) {
            gamma += "1";
            epsilon += "0";
        } else {
            gamma += "0";
            epsilon += "1";
        }
    }

    const g = parseInt(gamma, 2);
    const e = parseInt(epsilon, 2);

    return g * e;
}

export function getMostCommon(nums: string[], position: number): string {
    let zeros = 0;
    let ones = 0;
    nums.forEach(num => {
        if(num[position] == "0"){
            zeros += 1;
        } else {
            ones += 1;
        }
    })
    if(zeros == ones) {
        return "1";
    }
    if(zeros > ones) {
        return "0";
    } else {
        return "1";
    }
}

export function filterPos(input: string[], matchChar: string, position: number): string[] {
    const res = input.filter(num => num[position] == matchChar);
    //console.log(res);
    return res;
}

export function getOxygen(input: string[]): number {
    let o2 = 0;
    const digits = input[0].length;
    let remaining = [...input];
    for(let i = 0; i < digits; i++) {
        const common = getMostCommon(remaining, i);
        remaining = filterPos(remaining, common, i);
        if(remaining.length == 1) {
            o2 = parseInt(remaining[0], 2);
            break;
        }
    }
    return o2;
}

export function getCO2(input: string[]): number {
    let CO2 = 0;
    const digits = input[0].length;
    let remaining = [...input];
    for(let i = 0; i < digits; i++) {
        const common = getMostCommon(remaining, i);
        let leastCommon = "1";
        if(common == "1") { leastCommon = "0"; }
        remaining = filterPos(remaining, leastCommon, i);
        if(remaining.length == 1) {
            CO2 = parseInt(remaining[0], 2);
            break;
        }
    }
    return CO2;
}