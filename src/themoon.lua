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
--]]

-- LEXER
-- The Lexer Job is to read the code as a raw String and break it into tokens. A token is a word that the Parser knows for sure

Lexer = {}

Lexer.init_lexer = function()
  Lexer.buffer = io.read("*all")
  Lexer.curr_position = 0
  Lexer.curr_char = nil
  Lexer.next_char = nil
  Lexer.curr_line = 1
  Lexer.curr_column = 0
  Lexer.token_column = 0
  Lexer.token_line = 0
  Lexer.curr_token = Token(nil)
  Lexer.should_stop = false
  Lexer.move_foward()
end

Lexer.move_foward = function(i)
  i = i or 1
  Lexer.curr_position = Lexer.curr_position + i
  Lexer.curr_char = string.sub(Lexer.buffer, Lexer.curr_position, Lexer.curr_position)
  Lexer.curr_column = Lexer.curr_column + i
end

Lexer.peek_next = function(i)
  i = i or 1
  return string.sub(Lexer.buffer, Lexer.curr_position + i, Lexer.curr_position + i)
end

is_letter = function(char)
  return ((string.byte(char) >= 65 and string.byte(char) <= 90) or (string.byte(char) >= 97 and string.byte(char) <= 122))
end

is_number = function(char)
  return (string.byte(char) >= 48 and string.byte(char) <= 57)
end

is_name = function(char)
  return is_letter(char) or is_number(char) or string.byte(char) == 95
end


Token = function(tag, val)
  return { tag = tag, value = val }
end

Lexer.tokenize = function()
  Lexer.curr_token = Token("ERR")
  Lexer.token_column = Lexer.curr_column
  Lexer.token_line = Lexer.curr_line

  if Lexer.curr_char == "" or Lexer.curr_char == nil then
    Lexer.curr_token = Token("EOF")
    Lexer.should_stop = true

    -- single char tokens
  elseif Lexer.curr_char == "+" then
    Lexer.curr_token = Token("+")                                  -- +
  elseif Lexer.curr_char == "-" then
    Lexer.curr_token = Token("-")                                  -- -
  elseif Lexer.curr_char == "*" then
    Lexer.curr_token = Token("*")                                  -- *
  elseif Lexer.curr_char == "/" then
    Lexer.curr_token = Token("/")                                  -- /
  elseif Lexer.curr_char == "%" then
    Lexer.curr_token = Token("%")                                  -- %
  elseif Lexer.curr_char == "^" then
    Lexer.curr_token = Token("^")                                  -- ^
  elseif Lexer.curr_char == "#" then
    Lexer.curr_token = Token("#")                                  -- #
  elseif Lexer.curr_char == ";" then
    Lexer.curr_token = Token(";")                                  -- ;
  elseif Lexer.curr_char == ":" then
    Lexer.curr_token = Token(":")                                  -- :
  elseif Lexer.curr_char == "," then
    Lexer.curr_token = Token(",")                                  -- ,
  elseif Lexer.curr_char == "(" then
    Lexer.curr_token = Token("(")                                  -- (
  elseif Lexer.curr_char == ")" then
    Lexer.curr_token = Token(")")                                  -- )
  elseif Lexer.curr_char == "[" then
    Lexer.curr_token = Token("[")                                  -- [
  elseif Lexer.curr_char == "]" then
    Lexer.curr_token = Token("]")                                  -- ]
  elseif Lexer.curr_char == "{" then
    Lexer.curr_token = Token("{")                                  -- {
  elseif Lexer.curr_char == "}" then
    Lexer.curr_token = Token("}")                                  -- }

    -- multichar tokens
  elseif Lexer.curr_char == "=" then
    if Lexer.peek_next() == "=" then
      Lexer.curr_token = Token("==")                                -- ==
      Lexer.move_foward()
    else
      Lexer.curr_token = Token("=") -- =
    end
  elseif Lexer.curr_char == "~" then
    if Lexer.peek_next() == "=" then
      Lexer.curr_token = Token("~=")                                -- ~=
      Lexer.move_foward()
    else
      Lexer.curr_token = Token("ERR")
      Lexer.should_stop = true
    end
  elseif Lexer.curr_char == "<" then
    if Lexer.peek_next() == "=" then
      Lexer.curr_token = Token("<=")                                -- <=
      Lexer.move_foward()
    else
      Lexer.curr_token = Token("<") -- <
    end
  elseif Lexer.curr_char == ">" then
    if Lexer.peek_next() == "=" then
      Lexer.curr_token = Token(">=")                                -- >=
      Lexer.move_foward()
    else
      Lexer.curr_token = Token(">") --  >
    end
  elseif Lexer.curr_char == "." then
    if Lexer.peek_next() == "." then
      if Lexer.peek_next(2) == "." then
        Lexer.curr_token = Token("...")                                 -- ...
        Lexer.move_foward(2)
      else
        Lexer.curr_token = Token("..") -- ..
        Lexer.move_foward()
      end
    else
      Lexer.curr_token = Token(".") -- .
    end
  elseif Lexer.curr_char == " " then
    Lexer.move_foward()
    Lexer.tokenize()

  elseif Lexer.curr_char == "\n" then
      if Lexer.peek_next() == "" or Lexer.peek_next() == nil then
        Lexer.move_foward()
        Lexer.curr_token = Token("EOF")
        Lexer.should_stop = true
        return

      end
      Lexer.curr_line = Lexer.curr_line + 1
      Lexer.curr_column = 0
      Lexer.move_foward()
      Lexer.tokenize()
    -- TODO: implement other escape sequencies

    -- read names
  elseif (Lexer.curr_char == "_") or is_letter(Lexer.curr_char) then
    I = 0
    while is_name(Lexer.peek_next(I)) do
      I = I + 1
    end
    Name = string.sub(Lexer.buffer, Lexer.curr_position, Lexer.curr_position + I - 1)
    if Name == "and" then Lexer.curr_token = Token("and")
    elseif Name == "break" then Lexer.curr_token = Token("break")
    elseif Name == "do" then Lexer.curr_token = Token("do")
    elseif Name == "else" then Lexer.curr_token = Token("else")
    elseif Name == "elseif" then Lexer.curr_token = Token("elseif")
    elseif Name == "end" then Lexer.curr_token = Token("end")
    elseif Name == "false" then Lexer.curr_token = Token("false")
    elseif Name == "for" then Lexer.curr_token = Token("for")
    elseif Name == "function" then Lexer.curr_token = Token("function")
    elseif Name == "if" then Lexer.curr_token = Token("if")
    elseif Name == "in" then Lexer.curr_token = Token("in")
    elseif Name == "local" then Lexer.curr_token = Token("local")
    elseif Name == "nil" then Lexer.curr_token = Token("nil")
    elseif Name == "not" then Lexer.curr_token = Token("not")
    elseif Name == "or" then Lexer.curr_token = Token("or")
    elseif Name == "repeat" then Lexer.curr_token = Token("repeat")
    elseif Name == "return" then Lexer.curr_token = Token("return")
    elseif Name == "then" then Lexer.curr_token = Token("then")
    elseif Name == "true" then Lexer.curr_token = Token("true")
    elseif Name == "until" then Lexer.curr_token = Token("until")
    elseif Name == "while" then Lexer.curr_token = Token("while")
    else
      Lexer.curr_token = Token("NAME", Name)
    end
    Lexer.move_foward(I - 1)

    -- read numbers
    -- TODO: read HEX
  elseif is_number(Lexer.curr_char) then
    I = 0
    while is_number(Lexer.peek_next(I)) do
      I = I + 1
    end
    Number = string.sub(Lexer.buffer, Lexer.curr_position, Lexer.curr_position + I - 1)
    Lexer.move_foward(I - 1)
    Lexer.curr_token = Token("NUMBER", Number)

    -- read strings
  elseif Lexer.curr_char == "\"" then
    I = 1
    while (Lexer.peek_next(I) ~= "\"" or Lexer.peek_next(I - 1) == "\\" ) do
      I = I + 1
    end
    String = string.sub(Lexer.buffer, Lexer.curr_position+1, Lexer.curr_position + I - 1)
    Lexer.move_foward(I)
    Lexer.curr_token = Token("STRING", String)





  else
    print('its not a symbol.. Im reading "', Lexer.curr_char, '"')
    Lexer.curr_token = Token("ERR")
    Lexer.should_stop = true
  end

  return Lexer.curr_token
end

-- running the lexer

main = function()
  Lexer.init_lexer()
  --print("String:", Lexer.buffer)
  while not Lexer.should_stop do
    Lexer.tokenize()
    print(Lexer.token_line, "\t", Lexer.token_column, "\t", Lexer.curr_token.tag)
    if Lexer.curr_token.value ~= nil then print(Lexer.curr_token.value) end
    Lexer.move_foward()
  end
end

main()
