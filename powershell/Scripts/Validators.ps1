# Tests whether a given path exists on the file system
function Test-PathExists($path) {
    return Test-Path $path
}

# Validates that a path exists, throwing an exception if not found
function Assert-ValidPath($path) {
    if (-not (Test-PathExists $path)) {
        throw "Path does not exist: $path"
    }
}