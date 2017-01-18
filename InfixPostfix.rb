#
# InfixPostfix class contains methods for infix to postfix conversion and
# postfix expression evaluation.
#
class InfixPostfix
  
  # converts the infix expression string to postfix expression and returns it
  def infixToPostfix(exprStr)
	output = ""
	tempStack = Array.new
	tempStr = exprStr.split(" ")
	tempStr.each { |c|

		if operand? c
			output.concat("#{c} ")
		elsif isLeftParen? c
			tempStack.push c
		elsif operator? c
			x = inputPrecedence c
			y = stackPrecedence tempStack.last
			unless tempStack.last == nil || x == nil
			while y >= x do
				a = tempStack.pop
				output.concat("#{a} ")
				x = inputPrecedence c
				y = stackPrecedence tempStack.last
			end
			end

		tempStack.push c

		elsif isRightParen? c
			until isLeftParen? tempStack.last do
				a = tempStack.pop
				output.concat("#{a} ")
			end
			if isLeftParen? tempStack.last
				tempStack.pop
			end
		end
	}
	while tempStack.length > 1 do
		a = tempStack.pop
		output.concat("#{a} ")
	end
	if tempStack.length == 1
		a = tempStack.pop
		output.concat(a)
	end
	return output
  end
  
  # evaluate the postfix string and returns the result
  def evaluatePostfix(exprStr)
    	tempStack = Array.new
	tempStr = exprStr.split(" ")
	tempStr.each { |c|
	if operand? (c)
		tempStack.push c
	elsif operator? c
		y = tempStack.pop
		x = tempStack.pop
		temp = applyOperator x, y, c
		tempStack.push temp
	end
	}
	tempStack.pop
  end
  
  private # subsequent methods are private methods
  
  # returns true if the input is an operator and false otherwise
  def operator?(str)
 (str == "+") || (str == "-") || (str == "*") || (str == "/") || (str == "%") || (str == "^")
  end
  
  # returns true if the input is an operand and false otherwise
  def operand?(str)
	x = false
  	if !operator? str
		if !isLeftParen? str
			if !isRightParen? str
				unless str == " "
					x = true
				end	
			end
		end
	end
  return x		
  end
  
  # returns true if the input is a left parenthesis and false otherwise
  def isLeftParen?(str)
    str == "("
  end
  
  # returns true if the input is a right parenthesis and false otherwise
  def isRightParen?(str)
    str == ")"
  end
  
  # returns the stack precedence of the input operator
  def stackPrecedence(operator)
        	x = 0
	if (operator == "+" || operator == "-")
		x = 1
	elsif (operator == "*" || operator == "/" || operator == "%")
		x = 2
	elsif (operator == "^")
		x = 3
	elsif (operator == "(")
		x = -1
	end

	return x

  end
  
  # returns the input precedence of the input operator
  def inputPrecedence(operator)
    	x = 0
	if (operator == "+" || operator == "-")
		x = 1
	elsif (operator == "*" || operator == "/" || operator == "%")
		x = 2
	elsif (operator == "^")
		x = 4
	elsif (operator == "(")
		x = 5
	end

	return x
  end
  
  # applies the operators to num1 and num2 and returns the result
  def applyOperator(num1, num2, operator)
    result = 0
	if operator == "+"
		result = num1.to_i + num2.to_i
	elsif operator == "-"
		result = num1.to_i - num2.to_i
	elsif operator == "*"
		result = num1.to_i * num2.to_i
	elsif operator == "/"
		result = num1.to_i / num2.to_i
	elsif operator == "%"
		result = num1.to_i % num2.to_i
	elsif operator == "^"
		result = num1.to_i ** num2.to_i
	end
	return result
  end

end


#
#  main driver for the program - similar to the main() function in Project 2
#
def main()
  	x = InfixPostfix.new
	c = "+"
	d = "3"
	s = "("
	puts x.instance_eval{ operand? c }
	puts x.instance_eval{ operand? d }
	puts x.instance_eval{ operand? s }




end

# invoke main function
main()
