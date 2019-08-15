module Http.Xml exposing
    ( xmlBody
    , expectXml
    )

{-| Generates HTTP request for XML API.

Using [`Xml.Decode`][xd] for decoding XML response into Elm value.

[xd]: http://package.elm-lang.org/packages/ymtszw/elm-xml-decode/latest/Xml-Decode


# Request Body

@docs xmlBody


# Response Expectation

@docs expectXml

-}

import Http exposing (Body, Error, Expect)
import Xml.Decode exposing (Decoder)


{-| Put an XML string in the body. Adding `Content-type: application/xml` header.

Note: Currently `elm-xml-decode` package DOES NOT provide XML "encode" functions,
nor `elm-xml-parser`. Contributions are welcomed!

-}
xmlBody : String -> Body
xmlBody =
    Http.stringBody "application/xml"



-- RESPONSE EXPECTATION


{-| Expect the response body to be XML.

You provide [`Xml.Decode.Decoder`][xdd] to decode that XML into Elm value.

[xdd]: http://package.elm-lang.org/packages/ymtszw/elm-xml-decode/latest/Xml-Decode#Decoder

Note: Currently, `Expect` type does not come with content-negotiation capability using `Accept` header.
So if your target APIs require `Accept: application/xml` headers,
you have to insert them using [`Http.request`](https://package.elm-lang.org/packages/elm/http/latest/Http#request).

See this issue: <https://github.com/elm/http/issues/54>

-}
expectXml : (Result Error a -> msg) -> Decoder a -> Expect msg
expectXml toMsg decoder =
    Http.expectStringResponse toMsg <|
        \response ->
            case response of
                Http.BadUrl_ url ->
                    Err (Http.BadUrl url)

                Http.Timeout_ ->
                    Err Http.Timeout

                Http.NetworkError_ ->
                    Err Http.NetworkError

                Http.BadStatus_ metadata _ ->
                    Err (Http.BadStatus metadata.statusCode)

                Http.GoodStatus_ _ body ->
                    case Xml.Decode.run decoder body of
                        Ok value ->
                            Ok value

                        Err err ->
                            Err (Http.BadBody err)
