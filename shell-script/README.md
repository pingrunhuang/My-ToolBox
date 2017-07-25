
### positional parameters
`$#` return the number of parameters.  
`$1` get the first argument value. Same goes to 2 to 9.  
`${10}` get the tenth argument value. For historical reasons, have to add {} to later position.  
`$*` Represents all the command-line arguments as a single string which can be iterated by `for i in $*`. Same as `$@` With quotes, `"$*"` represents the whole string which can not be iterated.
`$?` Exit status of previous command. 0 means success. 126 means Command found, but file was not executable. 127 means Command not found. > 128 means Command died due to receiving a signal.
