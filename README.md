## Elm recursive types

Creating recursive data type representing Html structure and recursively rendering it into actuall Html through Elm.

Elm's compiler hint on this topic: https://github.com/elm-lang/elm-compiler/blob/0.18.0/hints/recursive-alias.md

*Variant 1 - Recursive Type*

```
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
```

*Variant 2 - Recursive Type Alias*

```
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
```
