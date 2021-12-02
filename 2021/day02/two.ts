export function getTwo(): number { return 2; }

export function getInput(filename: string): string[] {
    const content = Deno.readTextFileSync(filename);
    return content.split("\n");
}

export function moveSub(moves: string[]): number[] {
    let position = 0;
    let depth = 0;
    moves.forEach(move => {
        const parts = move.split(" ");
        const direction = parts[0];
        const amount = parseInt(parts[1]);
        switch(direction) {
            case 'forward':
                position += amount;
                break;
            case 'down':
                depth += amount;
                break;
            case 'up':
                depth -= amount;
                break;
            default:
                console.log("Bad direction");
                break;
        }
    })
    return [position, depth];
}

export function moveSubTwo(moves: string[]): number[] {
    let position = 0;
    let depth = 0;
    let aim = 0;
    moves.forEach(move => {
        const parts = move.split(" ");
        const direction = parts[0];
        const amount = parseInt(parts[1]);
        switch(direction) {
            case 'forward':
                position += amount;
                if(aim > 0) {
                    depth += amount * aim;
                }
                break;
            case 'down':
                aim += amount;
                break;
            case 'up':
                aim -= amount;
                break;
            default:
                console.log("Bad direction");
                break;
        }
    })
    return [position, depth];
}