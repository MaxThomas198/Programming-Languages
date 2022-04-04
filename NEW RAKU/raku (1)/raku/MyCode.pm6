use v6;
unit module MyCode;

#This function is adapted from the Tokenize function code
#Takes in list and returns a list of tokens in the form of TOKEN_TYPE:Value
sub getTokens ($program) is export {

  sub generateTokens($text, @resultsList) {
    my $newString = "";
	
	#An attempt at ignoring the line after a semi-colon
	if substr($text, 0..0) ~~ m/ ";" / {
	  my $ignorecoms = 0;
	  while $ignorecoms < $text.chars {
	    if substr($text, $ignorecoms..$ignorecoms) ~~ m/ "\\n" / {
          $newString = substr($text, $ignorecoms..$text.chars);
	    }
		else{
		$ignorecoms = $ignorecoms + 1;
		}
	  }
    }
    elsif substr($text, 0..0) ~~ m/(<:L>) / {
      if $text ~~ m/ (<:!L>) / {
        @resultsList.push("Identifier:" ~ $/.prematch);
        $newString = $/ ~ $/.postmatch;
      }
    }
    elsif substr($text, 0..0) ~~ m/ "\$" / {
      #say substr($text, 0..0);
      if substr($text, 1..$text.chars) ~~ m/ (<:!L>) / {
        #say $/;
        @resultsList.push("VAR:" ~ "\$" ~ $/.prematch);
        $newString = $/ ~ $/.postmatch;
      }
    }
    elsif substr($text, 0..0) ~~ m/ "=" / {
      @resultsList.push("ASSIGNOP:" ~ "=");
      $newString = substr($text, 1..$text.chars);
    }
    elsif substr($text, 0..0) ~~ m/ "+"|"-"|"*"|"/" / {
      @resultsList.push("MATHOP:" ~ substr($text, 0..0));
      $newString = substr($text, 1..$text.chars);
    }
    elsif substr($text, 0..0) ~~ m/(<:N>) / {
      if $text ~~ m/ (<:!N>) / {
        @resultsList.push("INTEGER:" ~ $/.prematch);
        $newString = $/ ~ $/.postmatch;
      }
    } 
    elsif substr($text, 0..0) ~~ m/ "(" / {
      @resultsList.push("LPAREN:" ~ "(");
      $newString = substr($text, 1..$text.chars);
    }      
    elsif substr($text, 0..0) ~~ m/ "<"|">" / {
      @resultsList.push("COMPOP:" ~ substr($text, 0..0));
      $newString = substr($text, 1..$text.chars);
    }       
    if substr($text, 0..0) ~~ m/ "\"" / {
      if substr($text, 1..$text.chars) ~~ m/ "\"" / {
        @resultsList.push("STRING:" ~ $/ ~ $/.prematch ~ $/);
        $newString = $/.postmatch;
      }
    }
    elsif substr($text, 0..0) ~~ m/ ")" / {
      @resultsList.push("RPAREN:" ~ ")");
      $newString = substr($text, 1..$text.chars);
    } 
    elsif substr($text, 0..0) ~~ m/ "\{" / {
      @resultsList.push("LBRACE:" ~ "\{");
      $newString = substr($text, 1..$text.chars);
    } 
    elsif substr($text, 0..0) ~~ m/ "\}" / {
      @resultsList.push("RBRACE:" ~ "\}");
      $newString = substr($text, 1..$text.chars);
    }
	elsif substr($text, 0..0) ~~ m/ "<[_A..Za..z]><[_A..Za..z0..9]>*" / {
      @resultsList.push("Identifier:" ~ "substr($text, 0..0)");
      $newString = substr($text, 1..$text.chars);
    }
	else {
	  $newString = substr($text, 1..$text.chars);
	}
	
  
    #Recursion ends when $text is empty
    if $newString.chars > 0 {
    return generateTokens($newString, @resultsList);
    }
    else {
      return @resultsList;
    }
  }


  my @results = "";
  
  my @newData = generateTokens($program, @results);

  return @newData;
}

sub balance (@tokens) is export {
  #Balance checks to see whether parentheses are even or odd.
  #If even function returns True, but if cnt is odd balance returns False.
  my $cnt = 0;
    for @tokens.comb {
        when ")" {
            --$cnt;
            return False if $l < 0;
        }
        when "(" {
            ++$cnt;
        }
    }
     return $cnt == 0;
}

# This code is adapted from the PrettyPrint function to work for the format function
sub format (@tokens) is export {
   
    # stores indent level (i.e., how many spaces at beginning of indent level)
    my $indentLevel = 0;

    # stores whether this is first token on line
    my $firstTokenOnLine = True;

    # return value at end of pretty print
    my $returnValue = "";

    # loop through every element in token and format
    for @tokens -> $element {
        # get just the token of the data
        my $elementToken = getTokenCharacter($element);
        my $firstChar = substr($elementToken, 0, 1);
        
        # variables that we'll flag in order to control indent levels and
        # new lines
        my $decrementThisLine = False;
        my $indentNextLine = False;
        my $addNewLine = False;

        # this will hold what text needs to be added
        my $whatToAdd = "";
        
        # switch-case based on first character of token
        given $firstChar {
            # most cases will be the same: print the token and add new line
            # special cases:
            # ( -> increase indent by 4
            # ) -> decrease indent by 4 
            when "\(" {
				$indentNextLine = True;
                $whatToAdd = "\(";
                $addNewLine = True;
            }
            when "\)" {
                $whatToAdd = "\)";
				$decrementThisLine = True;
                $addNewLine = True;
            }
            # default element token and add new line
            default {
                $whatToAdd = $whatToAdd ~ $elementToken;
				$addNewLine = True;
            }
        }
        
        # if removing indent, then decrease indent level
        if $decrementThisLine {
            $indentLevel = $indentLevel - 4;
            if $indentLevel < 0 {
                $indentLevel = 0;
            }
        }

        # indent if this is first token on line
        if $firstTokenOnLine {
            # create the indent
            my $indent = "";
            for 0..$indentLevel {
                $indent = $indent ~ " ";
            }
            $returnValue = $returnValue ~ $indent;
        }
        
        # if we are addding a new line, next thing has to be first token
        # otherwise, it will NOT be first token
        $firstTokenOnLine = $addNewLine;

        # if adding a new line
        if $addNewLine {
            $whatToAdd = $whatToAdd ~ "\n";
        }
		
        # if increasing indent, then increase indent level
        if $indentNextLine {
            $indentLevel = $indentLevel + 4;
        }

        # add our construction to return value
        $returnValue = $returnValue ~ $whatToAdd;
    }

    # return the big concatenated string
    return $returnValue;
}

#This is used as a helper function for the format function
#This is code from the PrettyPrint assingment
# Description:  Given a token description, return the actual token.
# Input:        A $data string containing the token description
# Output:       A $returnValue string containing the token itself
sub getTokenCharacter($data) is export {
    # split the data based on colon
    # colon is used in the Tokenize output
    my @dataSplit = split(/\:/, $data, :skip-empty, :v);

    my $returnValue = "";

    # use this to track once we've found the colon
    my $foundColon = False;

    for @dataSplit -> $element {
        if $foundColon == True {
            # after finding first colon, append all data to return value
            $returnValue = $returnValue ~ $element;
        }
        elsif $element eq ":" {
            # once we find first colon, mark everything after that as relevant
            $foundColon = True;
        }
        else {
            # do nothing before finding first colon
        }
    }
    return $returnValue;
}




