# elm-http-xml

[![Build Status](https://travis-ci.org/ymtszw/elm-http-xml.svg?branch=master)](https://travis-ci.org/ymtszw/elm-http-xml)

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
