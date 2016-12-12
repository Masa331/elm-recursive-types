module Main exposing (..)

import Html exposing (..)

main =
  view

type Node = Node { tag: String, children: List Node, value: String }

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
toHtmlMsg (Node node) =
  let
    childs = node.children
    value = if node.value == "" then [] else [Html.text node.value]
    msg = Html.node node.tag []
  in
    case childs of
      [] ->
        msg value
      x::xs ->
        msg ((List.map toHtmlMsg childs) ++ value)

p value childs =
  Node { tag = "p", value = value, children = childs }

div value childs =
  Node { tag = "div", value = value, children = childs }
