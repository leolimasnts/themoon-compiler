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
  Lexer.curr_line = 0
  Lexer.curr_column = 0
  Lexer.curr_token = nil
end


Lexer.move_foward = function()
  Lexer.curr_position = Lexer.curr_position + 1
  Lexer.curr_char = string.sub(Lexer.buffer, Lexer.curr_position, Lexer.curr_position)
end

Lexer.move_backward = function()
  Lexer.curr_position = Lexer.curr_position - 1
  Lexer.curr_char = string.sub(Lexer.buffer, Lexer.curr_position, Lexer.curr_position)
end

Token = function(key, val) return { key, val } end

--[[
if Lexer.curr_char == "+" or "-" or "*" or "/" or "%" or "^" or "#" or ";" or ":" or "," or "(" or ")" or "[" or "]" or "{" or "}" then
  Lexer.curr_token = Token(Lexer.curr_char)
end
--]]

Lexer.get_next_token = function()
  if Lexer.curr_char == "" then
    Lexer.curr_token = Token("EOF")
    -- single char tokens




  elseif Lexer.curr_char == "+" then
    Lexer.curr_token = Token("+") -- +
  elseif Lexer.curr_char == "-" then
    Lexer.curr_token = Token("-") -- -
  elseif Lexer.curr_char == "*" then
    Lexer.curr_token = Token("*") -- *
  elseif Lexer.curr_char == "/" then
    Lexer.curr_token = Token("/") -- /
  elseif Lexer.curr_char == "%" then
    Lexer.curr_token = Token("%") -- %
  elseif Lexer.curr_char == "^" then
    Lexer.curr_token = Token("^") -- ^
  elseif Lexer.curr_char == "#" then
    Lexer.curr_token = Token("#") -- #
  elseif Lexer.curr_char == ";" then
    Lexer.curr_token = Token(";") -- ;
  elseif Lexer.curr_char == ":" then
    Lexer.curr_token = Token(":") -- :
  elseif Lexer.curr_char == "," then
    Lexer.curr_token = Token(",") -- ,
  elseif Lexer.curr_char == "(" then
    Lexer.curr_token = Token("(") -- (
  elseif Lexer.curr_char == ")" then
    Lexer.curr_token = Token(")") -- )
  elseif Lexer.curr_char == "[" then
    Lexer.curr_token = Token("[") -- [
  elseif Lexer.curr_char == "]" then
    Lexer.curr_token = Token("]") -- ]
  elseif Lexer.curr_char == "{" then
    Lexer.curr_token = Token("{") -- {
  elseif Lexer.curr_char == "}" then
    Lexer.curr_token = Token("}") -- }





  elseif Lexer.curr_char == "=" then
    Lexer.move_foward()
    if Lexer.curr_char == "=" then
      Lexer.curr_token = Token("==") -- ==
    else
      Lexer.move_backward()
      Lexer.curr_token = Token("=") -- =
    end
  elseif Lexer.curr_char == "~" then
    Lexer.move_foward()
    if Lexer.curr_char == "=" then
      Lexer.curr_token = Token("~=") -- ~=
    else
      print("Error: could not identify char \"", Lexer.curr_char, "\"")
    end
  elseif Lexer.curr_char == "<" then
    Lexer.move_foward()
    if Lexer.curr_char == "=" then
      Lexer.curr_token = Token("<=") -- <=
    else
      Lexer.move_backward()
      Lexer.curr_token = Token("<") -- <
    end
  elseif Lexer.curr_char == ">" then
    Lexer.move_foward()
    if Lexer.curr_char == "=" then
      Lexer.curr_token = Token(">=") -- >=
    else
      Lexer.move_backward()
      Lexer.curr_token = Token(">") --  >
    end
  elseif Lexer.curr_char == "." then
    Lexer.move_foward()
    if Lexer.curr_char == "." then
      Lexer.move_foward()
      if Lexer.curr_char == "." then
        Lexer.curr_token = Token("...") -- ...
      else
        Lexer.move_backward()
        Lexer.curr_token = Token("..") -- ..
      end
    else
      Lexer.move_backward()
      Lexer.curr_token = Token(".") -- .
    end
  else
    print("its not a symbol..")
  end

-- 


  Lexer.move_foward()
  return Lexer.curr_token
end



-- running the lexer

Lexer.init_lexer()

print(Lexer.buffer)
