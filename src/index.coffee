import FS from "node:fs/promises"

Pkg =

  read: ->
    JSON.parse await FS.readFile "package.json", "utf8"

  getName: ( qname ) ->
    if qname.startsWith "@"
      ( qname.split "/" )[ 1 ]
    else qname

Resolvers =

  load: ->
    pkg = await do Pkg.read    
    for qname in Object.keys pkg.devDependencies
      name = Pkg.getName qname
      if name.startsWith "drn-"
        require require.resolve qname, 
          paths: [ "./node_modules" ]

export default Resolvers