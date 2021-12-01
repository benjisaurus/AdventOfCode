module Lib
    ( someFunc
    , countIncr
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
    

