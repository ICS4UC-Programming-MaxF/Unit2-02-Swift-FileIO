/**
 * Reads integers from input.txt line by line, sums each line,
 * and writes the sum (or an error message) to output.txt.
 *
 * @author  MF-ROB
 * @version 1.0
 * @since   2026-10-19
 */

import Foundation

do {
    // Read the whole input file as one string
    let contents = try String(contentsOfFile: "input.txt", encoding: .utf8)

    // Split into lines (drop the empty leftover after a trailing newline)
    var lines = contents.components(separatedBy: "\n")
    if lines.last == "" {
        lines.removeLast()
    }

    var results = ""
    var lineNumber = 0

    // Loop through every line of the input file
    for rawLine in lines {
        lineNumber += 1
        let line = rawLine.trimmingCharacters(in: .whitespacesAndNewlines)

        if line.isEmpty {
            results += "Line \(lineNumber) error: no data on this line\n"
            continue
        }

        let pieces = line.split(whereSeparator: { $0 == " " || $0 == "\t" })
        var sum = 0
        var badValue: String? = nil

        for piece in pieces {
            // Convert from String to Int (returns nil if it isn't a valid integer)
            if let value = Int(piece) {
                sum += value
            } else {
                badValue = String(piece)
                break
            }
        }

        if let bad = badValue {
            results += "Line \(lineNumber) error: \"\(bad)\" is not a valid integer\n"
        } else {
            results += "Line \(lineNumber) sum: \(sum)\n"
        }
    }

    // Write everything to output.txt
    try results.write(toFile: "output.txt", atomically: true, encoding: .utf8)

} catch {
    print("File error: \(error.localizedDescription)")
}