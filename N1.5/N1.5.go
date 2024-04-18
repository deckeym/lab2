package main

import (
	"fmt"
	"strings"
)

func StringFixer(Line string) (string, int) {
	var WorkRow strings.Builder
	count := 0
	Globalcount := 0

	for i := 0; i < len(Line)-1; i++ {
		codeSymbol := int(Line[i])
		codeSymbol++
		nextSymbol := byte(codeSymbol)
		WorkRow.WriteByte(Line[i])

		if Line[i] == Line[i+1] {
			count++
		}

		if count == 2 {
			WorkRow.WriteByte(nextSymbol)
			count = 0
			Globalcount++
		}
	}
	WorkRow.WriteByte(Line[len(Line)-1])

	return WorkRow.String(), Globalcount
}

func main() {
	var Globalcount int
	var Line string

	fmt.Print("Enter row, please - ")
	fmt.Scanln(&Line)

	FinalRow, Globalcount := StringFixer(Line)

	fmt.Printf("\nFixed row - %s\nValue of changes - %d", FinalRow, Globalcount)
}
