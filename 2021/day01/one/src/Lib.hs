module Lib
    ( someFunc
    , countIncr
    , partTwo
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"


countIncr nums =
    increases nums (maximum nums) 0
    where
        increases numList previous cnt =
            case numList of
                [] -> cnt
                h:t ->
                    if h > previous
                        then increases t h (cnt + 1)
                        else increases t h cnt

partTwo nums =
    increases nums (3 * maximum nums) 0
    where
        increases numList previous cnt =
            case ((length numList) > 2) of
                True ->
                    let n1:n2:n3:t = numList
                        currentSum = n1 + n2 + n3
                    in
                    if currentSum > previous
                        then increases (n2:n3:t) currentSum (cnt + 1)
                        else increases (n2:n3:t) currentSum cnt
                False ->
                    cnt