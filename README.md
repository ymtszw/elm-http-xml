# elm-http-xml

[![GitHub package version][v]](http://package.elm-lang.org/packages/ymtszw/elm-http-xml/latest)
[![license][l]](https://github.com/ymtszw/elm-http-xml/blob/master/LICENSE)

[v]: https://img.shields.io/badge/elm--package-1.0.1-blue.svg?maxAge=3600
[l]: https://img.shields.io/badge/license-BSD--3--Clause-blue.svg?maxAge=3600

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
