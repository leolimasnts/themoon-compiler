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
	Lexer.curr_line = 0
	Lexer.curr_column = 0
	Lexer.token_column = 0
	Lexer.token_line = 0
	Lexer.curr_token = nil
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

Token = function(key, val)
	return { key, val }
end

Lexer.tokenize = function()
	Lexer.curr_token = Token("ERR")
	Lexer.token_column = Lexer.curr_column
	Lexer.token_line = Lexer.curr_line

	if Lexer.curr_char == "" then
		Lexer.curr_token = Token("EOF")
		Lexer.should_stop = true

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

	-- multichar tokens
	elseif Lexer.curr_char == "=" then
		if Lexer.peek_next() == "=" then
			Lexer.move_foward()
			Lexer.curr_token = Token("==") -- ==
		else
			Lexer.curr_token = Token("=") -- =
		end
	elseif Lexer.curr_char == "~" then
		if Lexer.peek_next() == "=" then
			Lexer.move_foward()
			Lexer.curr_token = Token("~=") -- ~=
		else
			Lexer.curr_token = Token("ERR")
			Lexer.should_stop = true
		end
	elseif Lexer.curr_char == "<" then
		if Lexer.peek_next() == "=" then
			Lexer.move_foward()
			Lexer.curr_token = Token("<=") -- <=
		else
			Lexer.curr_token = Token("<") -- <
		end
	elseif Lexer.curr_char == ">" then
		if Lexer.peek_next() == "=" then
			Lexer.move_foward()
			Lexer.curr_token = Token(">=") -- >=
		else
			Lexer.curr_token = Token(">") --  >
		end
	elseif Lexer.curr_char == "." then
		if Lexer.peek_next() == "." then
			if Lexer.peek_next(2) == "." then
				Lexer.move_foward(2)
				Lexer.curr_token = Token("...") -- ...
			else
				Lexer.move_foward()
				Lexer.curr_token = Token("..") -- ..
			end
		else
			Lexer.curr_token = Token(".") -- .
		end
	elseif Lexer.curr_char == " " then
		Lexer.move_foward()
		Lexer.tokenize()
	elseif Lexer.curr_char == "\n" then
		Lexer.curr_line = Lexer.curr_line + 1
		Lexer.curr_column = 0
		Lexer.move_foward()
		Lexer.tokenize()
	else
		print('its not a symbol.. Im reading "', Lexer.curr_char, '"')
		Lexer.curr_token = Token("ERR")
		Lexer.should_stop = true
	end

	return Lexer.curr_token
end

-- running the lexer

Lexer.init_lexer()

print("String:", Lexer.buffer)
while not Lexer.should_stop do
	Lexer.tokenize()
	print(Lexer.token_line, "\t", Lexer.token_column, "\t", next(Lexer.curr_token))
	Lexer.move_foward()
end
