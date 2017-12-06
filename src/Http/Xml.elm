module Http.Xml exposing (request, get, post, put, patch, xmlBody, expectXml)

{-| Generates HTTP request for XML API.

Using [`Xml.Decode`][xd] for decoding XML response into Elm value.

[xd]: http://package.elm-lang.org/packages/ymtszw/elm-xml-decode/latest/Xml-Decode


# Request Builders

@docs request, get, post, put, patch


# Request Body

@docs xmlBody


# Response Expectation

@docs expectXml

-}

import Http exposing (Expect, Request, Response, Header, Body)
import Xml.Decode exposing (Decoder)


{-| Create a request to URL that returns XML. Adding `Accept: application/xml` header.

It tries to decode XML response to Elm value.

    import Http
    import Xml.Decode exposing (single, string)

    getXml : Request String
    getXml =
        request "GET" [] "https://example.com/xml" Http.emptyBody (single string)

-}
request : String -> List Header -> String -> Body -> Decoder a -> Request a
request method headers url body decoder =
    Http.request
        { method = method
        , headers = acceptXmlHeader :: headers
        , url = url
        , body = body
        , expect = expectXml decoder
        , timeout = Nothing
        , withCredentials = False
        }


acceptXmlHeader : Header
acceptXmlHeader =
    Http.header "Accept" "application/xml"


{-| Create a GET request.
-}
get : String -> Decoder a -> Request a
get url =
    request "GET" [] url Http.emptyBody


{-| Create a POST request.
-}
post : String -> Body -> Decoder a -> Request a
post =
    request "POST" []


{-| Create a PUT request.
-}
put : String -> Body -> Decoder a -> Request a
put =
    request "PUT" []


{-| Create a PATCH request.
-}
patch : String -> Body -> Decoder a -> Request a
patch =
    request "PATCH" []



-- REQUEST BODY


{-| Put an XML string in the body. Adding `Content-type: application/xml` header.
-}
xmlBody : String -> Body
xmlBody =
    Http.stringBody "application/xml"



-- RESPONSE EXPECTATION


{-| Expect the response body to be XML.

You provide [`Xml.Decode.Decoder`][xdd] to decode that XML into Elm value.

[xdd]: http://package.elm-lang.org/packages/ymtszw/elm-xml-decode/latest/Xml-Decode#Decoder

-}
expectXml : Decoder a -> Expect a
expectXml =
    parseAndDecodeXml >> Http.expectStringResponse


parseAndDecodeXml : Decoder a -> Response String -> Result String a
parseAndDecodeXml decoder { body } =
    Xml.Decode.run decoder body
