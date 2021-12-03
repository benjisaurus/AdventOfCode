import { assertEquals } from "https://deno.land/std@0.116.0/testing/asserts.ts";
import { getThree,getInput,partOne,getMostCommon,filterPos,getOxygen,getCO2 } from "./three.ts";

Deno.test("get three", () => {
    const res = getThree();
    assertEquals(3, res);
});

Deno.test("get input", () => {
    const res = getInput("sample.txt");
    const expected = [
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010"
    ];
    assertEquals(expected, res);
});

Deno.test("part one", () => {
    const expected = 198;
    const input = [
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010"
    ];
    const res = partOne(input);
    assertEquals(expected, res);
})

Deno.test("get most common", () => {
    const input = [
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010"
    ];
    assertEquals("1", getMostCommon(input, 0));
    assertEquals("0", getMostCommon(input, 1));
})

Deno.test("filter position", () => {
    const input = [
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010"
    ];
    const res = filterPos(input, "1", 0);
    const expected = [
        "11110",
        "10110",
        "10111",
        "10101",
        "11100",
        "10000",
        "11001"
    ];
    assertEquals(expected, res);
})

Deno.test("get oxygen", () => {
    const input = [
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010"
    ];
    const res = getOxygen(input);
    assertEquals(23, res);
})

Deno.test("get CO2", () => {
    const input = [
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010"
    ];
    const res = getCO2(input);
    assertEquals(10, res);
})