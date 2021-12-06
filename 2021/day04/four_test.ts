import { assertEquals } from "https://deno.land/std@0.116.0/testing/asserts.ts";
import { 
    getFour,getInput,parseNums,parseBoard,
    initBoardMarks,markNumber,hasBingo,sumUnmarked
} from "./four.ts";

Deno.test("get four", () => {
    const res = getFour();
    assertEquals(4, res);
});

Deno.test("get input", () => {
    const res = getInput("sample.txt");
    const expected = [
            "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1",
            "22 13 17 11  0\n 8  2 23  4 24\n21  9 14 16  7\n 6 10  3 18  5\n 1 12 20 15 19",
            " 3 15  0  2 22\n 9 18 13 17  5\n19  8  7 25 23\n20 11 10 24  4\n14 21 16 12  6",
            "14 21 17 24  4\n10 16 15  9 19\n18  8 23 26 20\n22 11 13  6  5\n 2  0 12  3  7"
    ]
    assertEquals(expected, res);
})

Deno.test("parse nums", () => {
    const input = "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1";
    const res = parseNums(input);
    const expected = [
        7,  4,  9,  5, 11, 17, 23,  2,
        0, 14, 21, 24, 10, 16, 13,  6,
       15, 25, 12, 22, 18, 20,  8, 19,
        3, 26,  1
     ];
     assertEquals(expected, res);
})

Deno.test("parse board", () => {
    const input = "22 13 17 11  0\n 8  2 23  4 24\n21  9 14 16  7\n 6 10  3 18  5\n 1 12 20 15 19";
    const res = parseBoard(input);
    const expected = [
        [ 22, 13, 17, 11, 0 ],
        [ 8, 2, 23, 4, 24 ],
        [ 21, 9, 14, 16, 7 ],
        [ 6, 10, 3, 18, 5 ],
        [ 1, 12, 20, 15, 19 ]
      ];
      assertEquals(expected, res);
})

Deno.test("init mark boards", () => {
    const res = initBoardMarks(5, 5, 3);
    const expected = [
        [
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ]
        ],
        [
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ]
        ],
        [
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ]
        ]
    ];
    assertEquals(expected, res);
})

Deno.test("mark boards", () => {
    const boards = [
        [
            [ 22, 13, 17, 11, 0 ],
            [ 8, 2, 23, 4, 24 ],
            [ 21, 9, 14, 16, 7 ],
            [ 6, 10, 3, 18, 5 ],
            [ 1, 12, 20, 15, 19 ]
      ]
    ];
    const markBoards = [
        [
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ]
        ]
    ];
    const res = markNumber(22, boards, markBoards);
    assertEquals(1, res);
    const marked = [
        [
            [ 1,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ]
        ]
    ];
    const marked2 = [
        [
            [ 1,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ]
        ]
    ];
    assertEquals(marked, markBoards);
    const res2 = markNumber(99, boards, marked);
    assertEquals(0, res2);
    assertEquals(marked2, marked);
})

Deno.test("has bingo", () => {
    const b1 = [
        [
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ]
        ],
        [
            [ 1,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ]
        ]
    ];
    const b2 = [
        [
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ]
        ],
        [
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 1,1,1,1,1 ],
            [ 0,0,0,0,0 ]
        ]
    ];
    const b3 = [
        [
            [ 1,0,0,0,0 ],
            [ 1,0,0,0,0 ],
            [ 1,0,0,0,0 ],
            [ 1,0,0,0,0 ],
            [ 1,0,0,0,0 ]
        ],
        [
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ],
            [ 0,0,0,0,0 ]
        ]
    ];
    assertEquals(-1, hasBingo(b1));
    assertEquals(1, hasBingo(b2));
    assertEquals(0, hasBingo(b3));
})

Deno.test("sum unmarked", () => {
    const b1 = [
        [ 14, 21, 17, 24, 4 ],
        [ 10, 16, 15, 9, 19 ],
        [ 18, 8, 23, 26, 20 ],
        [ 22, 11, 13, 6, 5 ],
        [ 2, 0, 12, 3, 7 ]
    ];
    const m1 = [
        [ 1, 1, 1, 1, 1 ],
        [ 0, 0, 0, 1, 0 ],
        [ 0, 0, 1, 0, 0 ],
        [ 0, 1, 0, 0, 1 ],
        [ 1, 1, 0, 0, 1 ]
    ];
    const res = sumUnmarked(b1, m1);
    assertEquals(188, res);
})