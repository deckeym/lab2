#include <iostream>
#include <string>

using namespace std;

string StringFixer(const string& Line, int& Globalcount) // Func to change string
{
    string WorkRow = Line; 
    int count = 0; 
    for (int i = 0; i < WorkRow.length() - 1; i++)
    {
        int code_symbol = static_cast<int>(WorkRow[i]); 
        code_symbol++; 
        char next_symbol = static_cast<char>(code_symbol); 
        if (WorkRow[i] == WorkRow[i + 1]) 
        {
            count++; 
        }
        if (count == 2) 
        {
            WorkRow.insert(i + 1, 1, next_symbol); 
            count = 0; 
            Globalcount++; 
        }
    }
    return WorkRow; 
}

int main()
{
    int Globalcount = 0; 
    cout << "Enter row, please - ";
    string Line;
    getline(cin, Line); 
    string FinalRow = StringFixer(Line, Globalcount); 
    
    cout << endl << "Fixed row - " << FinalRow << endl << "Value of changes - " << Globalcount;
}