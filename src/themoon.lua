--[[
The Moon (From Soul Eater)
  A subset of the Lua Programming Language that compiles itself

                          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠤⠒⠀⠉⢉⠍⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                          ⠀⠀⠀⠀⠀⠀⠀⠀⠤⠈⠀⠀⠀⠀⠐⠔⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                          ⠀⠀⠀⠀⠀⢀⠔⠀⠀⠀⠀⠀⠀⢀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                          ⠀⠀⠀⠀⡰⠄⠀⠀⠀⠀⠀⠀⠀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                          ⠀⠀⠀⠌⠂⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                          ⠀⠀⠌⠸⠀⠀⠀⠀⠀⠀⠀⠀⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                          ⠀⡰⡄⠀⠀⠀⠀⠀⡄⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⢡⠀⠀⠀⠀⠀
                          ⠀⠡⠀⢠⠀⠀⠢⠀⢠⢠⠀⡀⠸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠈⢀⠀⠀⠀⠀⠀⠀
                          ⢼⠀⠈⠁⠀⠀⠀⢰⣩⣶⣿⣦⢀⠣⠀⠀⠀⠀⠀⢀⠠⠒⠀⠀⢀⠃⠀⠀⠀⠀⠀⡰
                          ⢾⠀⠀⢸⠀⡀⡀⢤⣿⣇⢂⣿⣇⠂⠀⠉⠉⠁⡀⠀⠀⠀⠐⡰⠀⠀⠀⠀⠀⠀⠀⢁
                          ⢶⠢⠀⡇⢘⡀⠈⡂⠬⣛⡛⡋⠝⠀⠀⢀⠄⠐⠈⠀⠄⡠⠈⠀⠀⠀⠀⠀⠀⢀⠂⢸
                          ⢸⠥⡇⢸⡏⠀⢢⡀⠀⠈⠐⠁⠀⠀⠀⢧⠄⠀⣉⣴⠋⠄⠀⠀⠀⠀⠀⠀⠠⠁⠀⡌
                          ⠀⡐⣚⠀⡌⡀⡇⠀⠓⠤⡀⠀⠀⠀⠀⠲⠉⠉⠂⠁⣠⠒⠀⠀⢐⠤⠐⡁⠄⠀⢀⠀
                          ⠀⠱⠡⢆⠹⠀⠣⡀⠀⠀⠀⠀⠉⠉⠒⡒⠚⠉⠉⡀⠀⠔⠀⢹⢸⠁⠁⠁⠀⠐⠋⠀
                          ⠀⠀⢣⠥⣀⠱⠀⠀⠑⠴⢀⠀⠀⠀⠀⢧⠀⣀⠤⠻⠀⠀⢀⠁⠀⠀⠀⠀⠐⠞⠀⠀
                          ⠀⠀⠀⠢⠋⡄⠙⡄⠀⠀⠀⠉⠉⠉⠉⠀⠀⠀⠀⠐⢀⠃⠀⠀⠀⠠⢅⠊⠀⠀⠀
                          ⠀⠀⠀⠀⠑⡐⣕⡀⠲⣀⠀⠀⠀⠀⠀⠀⢁⠀⠀⠀⠔⠁⠀⢀⢤⠛⠔⠀⠀⠀⠀⠀
                          ⠀⠀⠀⠀⠀⠀⠱⢼⡆⣀⠉⠲⠤⣀⣀⣀⣠⠤⠚⡀⡀⡀⡭⣋⠔⠀⠀⠀⠀⠀⠀⠀
                          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠬⣉⡉⠶⠹⣋⠝⠦⠚⣃⠭⠒⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
]]

-- LEXER
-- The Lexer's Job is to read the code as a raw String and break it into tokens. A token is a word that the Parser knows for sure

Lexer = {}

Init = function()
  Lexer.buffer = io.read("*a")
  Lexer.pos = 1
  Lexer.line = 1
  Lexer.column = 1
  Lexer.token = {}
  Lexer.keywords = {
    ["function"] = true,
    ["elseif"] = true,
    ["repeat"] = true,
    ["return"] = true,
    ["until"] = true,
    ["while"] = true,
    ["break"] = true,
    ["false"] = true,
    ["local"] = true,
    ["else"] = true,
    ["then"] = true,
    ["true"] = true,
    ["and"] = true,
    ["end"] = true,
    ["for"] = true,
    ["nil"] = true,
    ["not"] = true,
    ["do"] = true,
    ["if"] = true,
    ["in"] = true,
    ["or"] = true
  }
  Lexer.single_symbols = {
    ["+"] = true,
    ["-"] = true,
    ["*"] = true,
    ["/"] = true,
    ["%"] = true,
    ["^"] = true,
    ["#"] = true,
    [";"] = true,
    [":"] = true,
    [","] = true,
    ["("] = true,
    [")"] = true,
    ["["] = true,
    ["]"] = true,
    ["{"] = true,
    ["}"] = true,
    ["|"] = true,
    ["&"] = true
  }
end

Token = function(lin, col, tag, val)
  Lexer.token = { lin = lin, col = col, tag = tag, val = val }
end

Peek = function(i)
  i = i or 0
  return string.sub(Lexer.buffer, Lexer.pos + i, Lexer.pos + i)
end

Walk = function(i)
  i = i or 1
  while i > 0 do
    if (Peek() == "\n") then
      Lexer.line = Lexer.line + 1
      Lexer.column = 1
    else
      Lexer.column = Lexer.column + 1
    end
    Lexer.pos = Lexer.pos + 1
    i = i - 1
  end
end

Skip_garbage = function()
  if Peek() == " " then
    Walk()
    return Skip_garbage()
  elseif Peek() == "\n" then
    Walk()
    return Skip_garbage()
  elseif Peek() == "\t" then
    Walk()
    return Skip_garbage()
  elseif Peek() == "\r" then
    Walk()
    return Skip_garbage()
  elseif Peek() == "-" and Peek(1) == "-" then
    if Peek(2) == "[" and Peek(3) == "[" then
      G = 3
      while (not (Peek(G - 1) == "]" and Peek(G) == "]") and Peek(G) ~= "") do
        G = G + 1
      end
      Walk(G+1)
    else
      G = 1
      while Peek(G) ~= "" and Peek(G) ~= "\n" do
        G = G + 1
      end
      Walk(G)
    end
    return Skip_garbage()
  else
    return
  end
end

Print_error = function()
  print(Lexer.line, Lexer.column)
  os.exit(1)
end

Print_token = function(token)
  print(token.lin, token.col, token.tag)
  if token.val ~= nil then
    print(token.val)
  end
end

Is_letter = function(char)
  return (char ~= "") and
      ((string.byte(char) >= 65 and string.byte(char) <= 90) or (string.byte(char) >= 97 and string.byte(char) <= 122))
end

Is_number = function(char)
  return (char ~= "") and ((string.byte(char) >= 48 and string.byte(char) <= 57))
end

Is_name = function(char)
  return (char == "_") or Is_letter(char) or Is_number(char)
end

Is_symbol = function(char)
  return Lexer.single_symbols[char] or char == "=" or char == "~" or char == "<" or char == ">" or char == "." or char == "\\"
end

Read_symbol = function()
  if Lexer.single_symbols[Peek()] then
    Token(Lexer.line, Lexer.column, Peek())
    return 1
  elseif Peek() == "=" then
    if Peek(1) == "=" then
      Token(Lexer.line, Lexer.column, "==")
      return 2
    else
      Token(Lexer.line, Lexer.column, "=")
      return 1
    end
  elseif Peek() == "~" then
    if Peek(1) == "=" then
      Token(Lexer.line, Lexer.column, "~=")
      return 2
    else
      Token(Lexer.line, Lexer.column, "~")
      return 1
    end
  elseif Peek() == "\\" then
    if Peek(1) == "\\" then
      Token(Lexer.line, Lexer.column, "\\\\")
      return 2
    else
      Print_error()
    end
  elseif Peek() == "<" then
    if Peek(1) == "=" then
      Token(Lexer.line, Lexer.column, "<=")
      return 2
    elseif Peek(1) == "<" then
      Token(Lexer.line, Lexer.column, "<<")
      return 2
    else
      Token(Lexer.line, Lexer.column, "<")
      return 1
    end
  elseif Peek() == ">" then
    if Peek(1) == "=" then
      Token(Lexer.line, Lexer.column, ">=")
      return 2
    elseif Peek(1) == ">" then
      Token(Lexer.line, Lexer.column, ">>")
      return 2
    else
      Token(Lexer.line, Lexer.column, ">")
      return 1
    end
  elseif Peek() == "." then
    if Peek(1) == "." then
      if Peek(2) == "." then
        Token(Lexer.line, Lexer.column, "...")
        return 3
      else
        Token(Lexer.line, Lexer.column, "..")
        return 2
      end
    else
      Token(Lexer.line, Lexer.column, ".")
      return 1
    end
  end
end

Read_name = function()
  N = 0
  while Is_name(Peek(N)) do
    N = N + 1
  end
  Name = string.sub(Lexer.buffer, Lexer.pos, Lexer.pos + N - 1)
  if Lexer.keywords[Name] then
    Token(Lexer.line, Lexer.column, Name, nil)
  else
    Token(Lexer.line, Lexer.column, "NAME", Name)
  end
  return N
end

-- TODO: read float and hex
Read_number = function()
  N = 0
  while Is_number(Peek(N)) do
    N = N + 1
  end
  Number = string.sub(Lexer.buffer, Lexer.pos, Lexer.pos + N - 1)
  Token(Lexer.line, Lexer.column, "NUMBER", tonumber(Number))
  return N
end

Read_string = function()
  N = 1
  String = ""
  while Peek(N) ~= "\"" do
    if Peek(N) == "" then Print_error() end
    if Peek(N) == "\n" then Print_error() end
    if Peek(N) == "\\" then
      if Peek(N + 1) == "\\" then
        String = String .. "\\"
      elseif Peek(N + 1) == "\"" then
        String = String .. "\""
      elseif Peek(N + 1) == "\'" then
        String = String .. "\'"
      elseif Peek(N + 1) == "n" then
        String = String .. "\n"
      elseif Peek(N + 1) == "t" then
        String = String .. "\t"
      elseif Peek(N + 1) == "r" then
        String = String .. "\r"
      else
        Print_error()
      end
      N = N + 1
    else
      String = String .. Peek(N)
    end
    N = N + 1
  end
  N = N + 1
  Token(Lexer.line, Lexer.column, "STRING", String)
  return N
end

Next_token = function()
  Skip_garbage()
  if Peek() == "_" or Is_letter(Peek()) then
    N = Read_name()
  elseif Is_number(Peek()) then
    N = Read_number()
  elseif Is_symbol(Peek()) then
    N = Read_symbol()
  elseif Peek() == "\"" then
    N = Read_string()
  elseif Peek() == "" then
    Token(Lexer.line, Lexer.column, "EOF")
    N = 0
  else
    Print_error()
  end
  Walk(N)
end

Main = function()
  Init()
  while true do
    Next_token()
    Print_token(Lexer.token)
    if Lexer.token.tag == "EOF" then return end
  end
end

Main()
