module Main exposing (..)

import Html exposing (..)

type Children = Children (List Node)
type alias Node = { tag: String, value: String, children: Children }

main =
  view

view : Html msg
view =
  let
    node =
      div ""
        [ p "Hi, first line" []
        , p "Hi, second line" []]
  in
    toHtmlMsg node

toHtmlMsg : Node -> Html msg
toHtmlMsg node =
  let
    childs = (\ (Children childs) -> childs) node.children
    value = if node.value == "" then [] else [Html.text node.value]
    msg = Html.node node.tag []
  in
    case childs of
      [] ->
        msg value
      x::xs ->
        msg ((List.map toHtmlMsg childs) ++ value)

p value childs =
  Node "p" value (Children childs)

div value childs =
  Node "div" value (Children childs)
