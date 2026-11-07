.pragma library

// Build the argv of one CLI action.
//
// A JS array handed to an action comes back from a QML `var` property or a
// signal as a sequence (V4Sequence inside Quickshell on Qt 6.12), for which
// Array.isArray() is false. Such a list must still become one argv entry per
// element: as a single "entity,0" argument the CLI ignores the whole command
// and playback silently never starts.
function forAction(cli, command, argument) {
  var args = [cli, command]
  if (argument !== null && argument !== undefined && typeof argument === "object"
      && typeof argument.length === "number") {
    for (var i = 0; i < argument.length; i++) args.push(String(argument[i]))
  } else if (argument !== undefined && argument !== null) {
    args.push(String(argument))
  }
  return args
}
