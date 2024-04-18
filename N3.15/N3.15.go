package main

import (
	"fmt"
)

func ReglamentCheck(num int) bool {
	prevDigit := num % 10
	num = num / 10
	for num != 0 {
		currentDigit := num % 10
		if currentDigit <= prevDigit {
			prevDigit = currentDigit
			num /= 10
		} else {
			return false
		}
	}
	return true
}

func NumReverser(numblank int) int {
	if ReglamentCheck(numblank) {
		reversedNum := 0
		for numblank != 0 {
			reversedNum = reversedNum*10 + numblank%10
			numblank /= 10
		}
		return reversedNum
	} else {
		return 0
	}
}

func main() {
	const defaultCount = 4
	n := defaultCount

	for i := 0; i < n; i++ {
		var number int
		fmt.Scan(&number)
		fmt.Printf("%d ", NumReverser(number))
	}
	fmt.Println()
}