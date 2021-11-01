require 'json'
require "set"


class WordFinder
  def find(letters)

    file = File.read('./dictionary.json')
    data_hash = JSON.parse(file)
    dictionary = data_hash.to_set
    
    resultsArray = Array.new
    
    dictionary.each { |word|
        currentWord = word
        currentWord = word.split("")
        letterInstance = letters.split("")
        isPossibleWord = true

        currentWord.each_with_index { |char, index| 

            if letterInstance.include? char
                letterInstance.delete_at(letterInstance.index(char))
            # Here we could put something that just moves us to the next word, instead of continuing to go through currentWord. How to do that? next just takes us to the next letter in word, which the end of this if statment does anyway. How do we next to dictionary.each?
            else 
                isPossibleWord = false
            end
            if currentWord.length-1 == index && isPossibleWord
                resultsArray.push(word)
            end
        }

    }
    return resultsArray

    end
end


# //one option is to create all the possible words with the input letters, and then seeing if that word is contained in the json file. This is probably not efficient, but it would work.
# create set, iterate starting at letter 1, add that to set. ...This method will prove to be tedeious

# //another option is to go through every entry in the dictionary, and see if the character string can be created with the letters. 
# for loop whole dictionary	
# let word= dictionary.word[i]
# let letterparse = letters
# for loop lettters in word
# if letter from word is in letters
# 	remove that letter from the word, by getting the index and doing some slicing
# 		if i = last letter in string, add to wordArray
# if letter not in word, move onto next word
# Time Complexity O(n squared) loop through dictionary, loop through word