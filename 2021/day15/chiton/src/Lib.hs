module Lib
    ( someFunc
    , getNeighborCoords
    , parseInput
    , getInput
    , pathSum
    ) where

import Data.List.Split
import Data.Char (digitToInt)
import qualified Data.HashMap as HM
import Control.Arrow (Arrow(second))
import Data.Bits (Bits(xor))

someFunc =
    putStrLn "someFunc"

--getNeighborCoords::Int->Int->Int->Int->[(Int,Int)]
getNeighborCoords r c grid =
    let rowMax = length grid
        colMax = length (grid!!0)
    in
        filter (\(a,b) -> a >=0 && b >= 0 && a < rowMax && b < colMax) [ (r + 1, c)
        --, (r - 1, c)
        --, (r, c - 1)
        , (r, c + 1)]

pathSum path grid=
    sum (map (\coord ->
            case HM.lookup coord grid of
                Just x -> x
                _ -> 0
        ) path)

getPath path grid =
    let rowMax = length grid
        colMax = length (grid!!0)
        (r,c) = head path
        neighborCoords = getNeighborCoords r c grid
    in
        case (rowMax - 1,colMax - 1) == (r,c) of
            True -> path
            False -> path

parseInput rows =
    let rowNum = length rows
        colNum = length (rows!!0)
    in
        HM.fromList [((row, col), read [rows!!row!!col] ::Int) | row <- [0..rowNum-1], col <- [0..colNum-1]]

--getInput::[String]
getInput =
    splitOn "\n" "1163751742\n\
              \1381373672\n\
              \2136511328\n\
              \3694931569\n\
              \7463417111\n\
              \1319128137\n\
              \1359912421\n\
              \3125421639\n\
              \1293138521\n\
              \2311944581"
