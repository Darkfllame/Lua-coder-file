local help = "CoderFile.lua [mode] [fileName] [byteOffset]\n\nModes :\n-e|--encode     to encode the file\n-d|--decode     to decode the file"
local args = {...}
local encode, decode, fileName, byteOffset, file, fileContent, finalFile = args[1] == "-e" or args[1] == "--encode", args[1] == "-d" or args[1] == "--decode", args[2], tonumber(args[3]), nil, "", ""
if #args == 0 then print(help) return end
if not encode and not decode then error("no mode specified") end
if fileName == "" then error("no file specified") end
file = io.open(fileName, "r")
fileContent = file:read("a")
file:close()
print("converting file...")
for i=1, #fileContent, 1 do
    char = fileContent:sub(i,i)
    if encode then
        char = string.char(char:byte()+byteOffset)
    elseif decode then
        char = string.char(char:byte()-byteOffset)
    else
        error("error while converting file")
    end
    finalFile = finalFile..char
end
local mode = ""
if encode then
    mode = "encoded"
elseif decode then
    mode = "decoded"
else
    error("error while writing to file")
end
file = io.open(mode.."_"..fileName, "w")
file:write(finalFile)
file:close()
print("program ended")
return