module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text, input)
import Html.Events exposing (onClick)
import Html exposing (textarea)
import Html.Events exposing (onInput)
import Html.Attributes exposing (value)
import Dict exposing (Dict)

main =
  Browser.sandbox { 
      init = init
      , update = update
      , view = view 
      }

type alias Model =
  { inputStr : String
  , outputStr : List (List String)
  , connections : Dict String (List String)
  }

init : Model
init =
  { inputStr = ""
  , outputStr = []
  , connections = Dict.fromList []
  }

type Msg input = TakeInput input | Process

update msg model =
  case msg of

    TakeInput input ->
      { model | inputStr = input }
    
    Process ->
      { model | outputStr = (parseInput model.inputStr), inputStr = "" }

parseInput inStr =
  List.map (\s -> (String.split "-" s)) (String.split "\n" inStr)

viewOutList lst =
  case (List.head lst) of
     Nothing -> "Nothing"
     Just items -> "items"

view model =
  div []
    [ textarea [ value model.inputStr, onInput TakeInput ] [ ]
    , div [] [ button [ onClick Process] [ text "Process"] ]
    , div [] [ text (viewOutList model.outputStr) ] --model.outputStr ]
    ]