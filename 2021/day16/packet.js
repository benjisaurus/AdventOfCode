function part1(binStr) {
    console.log(binStr);
    const pVersion = parseInt(binStr.substring(0,3), 2);
    const pType = binStr.substring(3,6);
    if(pType == '100') { return pVersion; }
    if(binStr[6] == '0'){
        const p2len = parseInt(binStr.substring(7,22));
        return pVersion + part1(binStr.substring(22,(22+p2len)));
    } else {
        const pNum = parseInt(binStr.substring(7,18));
        return 100;
    }
}

const input = Array.from('38006F45291200').map(ch => parseInt(ch, 16).toString(2).padStart(4,'0')).join('');
console.log(part1(input));