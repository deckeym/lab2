package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strings"
)

func WordConverter(fourthblank string) []string {
	convertedWord := []string{}
	blankWord := fourthblank
	blankWordSlice := strings.Split(blankWord, "")
	sort.Strings(blankWordSlice)
	convertedWord = append(convertedWord, strings.Join(blankWordSlice, ""))
	for {
		i := len(blankWordSlice) - 2
		for i >= 0 && blankWordSlice[i] >= blankWordSlice[i+1] {
			i--
		}
		if i < 0 {
			break
		}
		j := len(blankWordSlice) - 1
		for blankWordSlice[j] <= blankWordSlice[i] {
			j--
		}
		blankWordSlice[i], blankWordSlice[j] = blankWordSlice[j], blankWordSlice[i]
		left := i + 1
		right := len(blankWordSlice) - 1
		for left < right {
			blankWordSlice[left], blankWordSlice[right] = blankWordSlice[right], blankWordSlice[left]
			left++
			right--
		}
		convertedWord = append(convertedWord, strings.Join(blankWordSlice, ""))
	}
	return convertedWord
}

func StringSplitter(enterString string) []string {
	splittedString := strings.Split(enterString, " ")
	return splittedString
}

func Translate(wordToTranslate string, dictionary map[string]string) string {
	translatedWord := ""
	for _, char := range wordToTranslate {
		translatedWord += dictionary[string(char)]
	}
	return translatedWord
}

func UnicChecker(translatedAllCombinations []string, rnComb string) string {
	scoreOfSames := 0
	for _, word := range translatedAllCombinations {
		if rnComb == word {
			scoreOfSames++
		}
	}
	if scoreOfSames > 1 {
		return ""
	} else {
		return rnComb
	}
}

func main() {
	dictionary := map[string]string{
		"a": ".-", "b": "-...", "w": ".--", "g": "--.", "d": "-..",
		"e": ".", "v": "...-", "z": "--..", "i": "..", "j": ".---",
		"k": "-.-", "l": ".-..", "m": "--", "n": "-.", "o": "---",
		"p": ".--.", "r": ".-.", "s": "...", "t": "-", "u": "..-",
		"f": "..-.", "h": "....", "c": "-.-.", "q": "--.-", "y": "-.--", "x": "-..-",
	}

	scanner := bufio.NewScanner(os.Stdin)
	fmt.Print("Enter String - ")
	scanner.Scan()
	enterString := scanner.Text()

	splittedString := StringSplitter(enterString)

	boolCheckOfWordLength := true
	for _, word := range splittedString {
		if len(word) > 9 {
			boolCheckOfWordLength = false
			break
		}
	}

	boolCheckOfStringLength := true
	if len(enterString) > 100 || len(enterString) < 1 {
		boolCheckOfStringLength = false
	}

	if !boolCheckOfStringLength || !boolCheckOfWordLength {
		fmt.Println("Please, enter correct string")
	} else {
		allCombinations := []string{}
		for _, word := range splittedString {
			for _, combination := range WordConverter(word) {
				allCombinations = append(allCombinations, combination)
			}
		}

		translatedAllCombinations := []string{}
		for _, wordToTranslate := range allCombinations {
			translatedAllCombinations = append(translatedAllCombinations, Translate(wordToTranslate, dictionary))
		}

		unicCombinations := []string{}
		for _, rnComb := range translatedAllCombinations {
			if result := UnicChecker(translatedAllCombinations, rnComb); result != "" {
				unicCombinations = append(unicCombinations, result)
			}
		}

		fmt.Println()
		fmt.Println("All combinations and their Morze translation:")
		for i := 0; i < len(allCombinations); i++ {
			fmt.Printf("%s = (%s)\n", allCombinations[i], translatedAllCombinations[i])
		}

		fmt.Println("Unic words:")
		for _, output := range unicCombinations {
			fmt.Printf("(%s) ", output)
		}
		fmt.Println()
		fmt.Println("____________________________________________________")
		fmt.Printf("Value of unic words - %d\n", len(unicCombinations))
	}
}