/*
 * Reads each line of integers from input.txt, adds them up, and writes
 * the sum to output.txt. If a line is empty or has a value that is not
 * an integer, an error message is written to output.txt instead.
 *
 * @author  MF-ROB
 * @version 1.0
 * @since   2026-09-24
 */

import Foundation

let inputPath = "input.txt"
let outputPath = "output.txt"

// Create a sample input file if it doesn't exist
if !FileManager.default.fileExists(atPath: inputPath) {
    let sample = "1 2 3\n4 five 6\n-3 7 2\n\n0\n"
    try? sample.write(toFile: inputPath, atomically: true, encoding: .utf8)
}

guard let contents = try? String(contentsOfFile: inputPath, encoding: .utf8) else {
    print("File error: could not read \(inputPath)")
    exit(1)
}

var output = ""
var lines = contents.components(separatedBy: "\n")

// A trailing newline creates one extra empty element at the end; drop it
if lines.last == "" {
    lines.removeLast()
}

for rawLine in lines {
    let line = rawLine.trimmingCharacters(in: .whitespaces)

    if line.isEmpty {
        output += "Error: no data on this line\n"
        continue
    }

    let pieces = line.components(separatedBy: " ")
    var sum = 0
    var badValue: String? = nil

    for piece in pieces {
        if let number = Int(piece) {
            sum += number
        } else {
            badValue = piece
            break
        }
    }

    if let bad = badValue {
        output += "Error: \"\(bad)\" is not a valid integer\n"
    } else {
        output += "\(sum)\n"
    }
}

do {
    try output.write(toFile: outputPath, atomically: true, encoding: .utf8)
} catch {
    print("File error: could not write \(outputPath)")
}
