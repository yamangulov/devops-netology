package main

import "fmt"

func main() {
	fmt.Print("Enter a number: ")
	var input float64
	_, err := fmt.Scanf("%f", &input)
	if err != nil {
		fmt.Print("You entered wrong number! Number must be float64!")
		return
	}
	output := fmt.Sprintf("%.4f", input*0.3048)
	fmt.Println(output)
}
