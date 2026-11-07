import QtQuick
import QtTest
import "../../CliArgs.js" as CliArgs

TestCase {
  name: "CliArgs"

  function test_list_argument_becomes_one_argv_entry_per_element() {
    compare(JSON.stringify(CliArgs.forAction("/cli", "play_catalog_track", ["entity", 0])),
      JSON.stringify(["/cli", "play_catalog_track", "entity", "0"]))
    compare(JSON.stringify(CliArgs.forAction("/cli", "createPlaylist",
        ["kind", "queue", 2, "track:7", "album:7", "New"])),
      JSON.stringify(["/cli", "createPlaylist", "kind", "queue", "2", "track:7", "album:7", "New"]))
  }

  // Quickshell hands a list back from a var-typed property or signal as a
  // sequence (V4Sequence on Qt 6.12): indexed and length-bearing, but
  // Array.isArray() is false. It must still be split into separate arguments.
  function test_sequence_argument_is_split_not_joined() {
    var sequence = { 0: "entity", 1: 0, length: 2 }
    compare(Array.isArray(sequence), false)
    compare(JSON.stringify(CliArgs.forAction("/cli", "play_catalog_track", sequence)),
      JSON.stringify(["/cli", "play_catalog_track", "entity", "0"]))
  }

  function test_scalar_and_empty_arguments() {
    compare(JSON.stringify(CliArgs.forAction("/cli", "catalog_artist", "4152457")),
      JSON.stringify(["/cli", "catalog_artist", "4152457"]))
    compare(JSON.stringify(CliArgs.forAction("/cli", "play_queue", 0)),
      JSON.stringify(["/cli", "play_queue", "0"]))
    compare(JSON.stringify(CliArgs.forAction("/cli", "pause", undefined)),
      JSON.stringify(["/cli", "pause"]))
    compare(JSON.stringify(CliArgs.forAction("/cli", "pause", null)),
      JSON.stringify(["/cli", "pause"]))
  }
}
