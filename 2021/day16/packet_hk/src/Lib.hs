module Lib
    ( someFunc
    , hexStrToBinStr
    , readBin
    ) where

import Numeric (readHex, readInt)
import Text.Printf (printf)
import Data.Char (digitToInt)
import Data.Maybe (listToMaybe)

someFunc :: IO ()
someFunc = putStrLn "someFunc"

hexStrToBinStr :: String -> String
hexStrToBinStr =
    let
        convert c = 
            case readHex [c] of
                (n,_):_ -> printf "%04b" (n::Int)
                _ -> ""
    in
    concatMap convert

readBin :: Integral a => String -> Maybe a
readBin = fmap fst . listToMaybe . readInt 2 (`elem` "01") digitToInt