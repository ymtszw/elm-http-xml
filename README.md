# elm-http-xml

[![GitHub package version](https://img.shields.io/github/package-json/v/badges/shields.svg)](http://package.elm-lang.org/packages/ymtszw/elm-http-xml/latest)
![license](https://img.shields.io/github/license/mashape/apistatus.svg)

Generates HTTP request for XML API. Can be used with [`elm-lang/http`][http].

Using [`ymtszw/elm-xml-decode`][exd] for decoding XML response into Elm values.

[http]: http://package.elm-lang.org/packages/elm-lang/http/latest
[exd]: http://package.elm-lang.org/packages/ymtszw/elm-xml-decode/latest

## Basic Example

```elm
import Http
import Http.Xml
import Xml.Decode exposing (single, string)

type Msg = XmlMsg (Result Http.Error String)

getXmlReq : Http.Request String
getXmlReq =
    Http.Xml.request "GET" [] "https://example.com/xml" Http.emptyBody (single string)

getXml : Cmd Msg
getXml =
    Http.send XmlMsg getXmlReq
```

## License

BSD-3-Clause
