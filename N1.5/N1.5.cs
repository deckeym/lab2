
using System;

class Program
{
    // Function to fix the string by inserting a character after every pair of consecutive identical characters
    // It also updates the global count of changes
    static string StringFixer(string Line, ref int Globalcount)
    {
        string WorkRow = Line; // Make a copy of the input string
        int count = 0; // Counter to keep track of consecutive identical characters
        for (int i = 0; i < WorkRow.Length - 1; i++)
        {
            int code_symbol = (int)WorkRow[i]; // Get the ASCII code of the current character
            code_symbol++; // Increment the ASCII code to get the next character
            char next_symbol = (char)code_symbol; // Convert the ASCII code back to a character
            if (WorkRow[i] == WorkRow[i + 1]) // Check if the current character is the same as the next one
            {
                count++; // Increment the count of consecutive identical characters
            }
            if (count == 2) // If there are two consecutive identical characters
            {
                WorkRow = WorkRow.Insert(i + 1, next_symbol.ToString()); // Insert the next character after the current one
                count = 0; // Reset the count
                Globalcount++; // Increment the global count of changes
            }
        }
        return WorkRow; // Return the modified string
    }

    static void Main()
    {
        int Globalcount = 0; // Counter to keep track of the global number of changes
        Console.Write("Enter row, please - ");
        string Line = Console.ReadLine(); // Read input from the user
        string FinalRow = StringFixer(Line, ref Globalcount); // Call the function to fix the string
        // Print the fixed string and the number of changes
        Console.WriteLine("\nFixed row - " + FinalRow + "\nValue of changes - " + Globalcount);
    }
}