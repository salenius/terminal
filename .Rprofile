## Varmista, että kirjastot haetaan oikeasta paikasta.

.libPaths("/Library/Frameworks/R.framework/Versions/3.5/Resources/library")

## Älä kysy haluatko tallentaa
## workspacea kun sessio lopetetaan.

utils::assignInNamespace(
  "q", 
  function(save = "no", status = 0, runLast = TRUE) 
  {
    .Internal(quit(save, status, runLast))
  }, 
  "base"
)
utils::assignInNamespace(
  "quit", 
  function(save = "no", status = 0, runLast = TRUE) 
  {
    .Internal(quit(save, status, runLast))
  }, 
  "base"
)
