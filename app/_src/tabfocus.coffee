# Tabfocus
# Detect if your browser tab has focus
# --------------------------------------------------

vis = do ->
  keys =
    hidden: "visibilitychange"
    webkitHidden: "webkitvisibilitychange"
    mozHidden: "mozvisibilitychange"
    msHidden: "msvisibilitychange"

  for stateKey of keys
    if stateKey of document
      eventKey = keys[stateKey]
      break
  (c) ->
    if c
      document.addEventListener eventKey, c
    not document[stateKey]

title = document.title
vis ->
  if vis()
    document.title = title
  else
    document.title = 'Em and Mike\'s Wedding'
  return