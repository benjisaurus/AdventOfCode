import { assertEquals } from "https://deno.land/std@0.116.0/testing/asserts.ts";
import { getTwo,getInput,moveSub,moveSubTwo } from "./two.ts"

Deno.test("get two", () => {
    const res = getTwo();
    assertEquals(res, 2);
});

Deno.test("get input", () => {
    const content = getInput("sample.txt");
    const expected = [
            "forward 5",
            "down 5",
            "forward 8",
            "up 3",
            "down 8",
            "forward 2"
            ];
    assertEquals(expected, content);
});

Deno.test("move", () => {
    const moves = [
        "forward 5",
        "down 5",
        "forward 8",
        "up 3",
        "down 8",
        "forward 2"
        ];
    const res = moveSub(moves);
    const expected = [15,10];
    assertEquals(expected, res);
});

Deno.test("move two", () => {
    const moves = [
        "forward 5",
        "down 5",
        "forward 8",
        "up 3",
        "down 8",
        "forward 2"
        ];
    const res = moveSubTwo(moves);
    const expected = [15,60];
    assertEquals(expected, res);
});