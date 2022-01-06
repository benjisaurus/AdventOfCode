// Learn more about F# at http://docs.microsoft.com/dotnet/fsharp

open System

let strToNums (sNums:string) =
    sNums |> Seq.toList |> Seq.map (fun n -> int n - int '0') |> Seq.toArray

let getInput filename =
    let content = System.IO.File.ReadAllText filename
    content.Split '\n'
    |> Seq.map strToNums
    |> Seq.toArray

let getNeighbors x y rows cols =
    seq {(x - 1, y); (x + 1, y); (x, y - 1); (x, y + 1)}
    |> Seq.filter (fun (a,b) -> a >= 0 && b >= 0 && a < cols && b < rows)

[<EntryPoint>]
let main argv =
    let infile = "../sample.txt"
    let grid = getInput infile
    let rows = grid.Length
    let cols = grid.[0].Length
    0 // return an integer exit code