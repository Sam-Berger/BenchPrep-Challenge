require 'json'
require "set"

class WordFinder
    def find(letters)
        dictionary = get_dictionary()
        
        resultsArray = Array.new
    
        dictionary.each do |word|
            currentWord = word.split("")
            letterInstance = letters.split("")
            isPossibleWord = true

            currentWord.each_with_index do |char, index| 

                if letterInstance.include? char
                    letterInstance.delete_at(letterInstance.index(char))
                # Here we could put something that just moves us to the next word, instead of continuing to go through currentWord.
                # However, I cannot find a way to do that, but it would eliminate some processing.
                # "next" just takes us to the next letter in word, which the end of this if statment does anyway. How do we next to dictionary.each?
                else 
                    isPossibleWord = false
                end
                if currentWord.length-1 == index && isPossibleWord
                    resultsArray.push(word)
                end
            end
        end
    return resultsArray
    end

    def get_dictionary()
        file = File.read(__dir__ + '/dictionary.json')
        data = JSON.parse(file)
        return data.to_set
    end

end