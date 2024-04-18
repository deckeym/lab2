#include <iostream>
#include <string>
#include <map>
#include <algorithm>
#include <vector>
#include <set>

using namespace std;

vector<string> WordConverter(const string& fourthblank) //func for Convert word from input string
{
    vector<string> ConvertedWord;
    string BlankWord = fourthblank;
    sort(BlankWord.begin(), BlankWord.end());
    ConvertedWord.push_back(BlankWord);
    while (next_permutation(BlankWord.begin(), BlankWord.end()))
    {
        ConvertedWord.push_back(BlankWord);
    }
    return ConvertedWord;
}

vector<string> StringSplitter(const string& EnterString) // func for split String
{
    vector<string> SplittedString;
    string MiniWord;
    for (int i = 0; i < EnterString.length(); i++)
    {
        if (EnterString[i] == ' ') 
        {
            SplittedString.push_back(MiniWord); 
            MiniWord = "";
            
        } else if (i == EnterString.length() - 1) 
        {
            MiniWord += EnterString[i];
            SplittedString.push_back(MiniWord); 
        }
        else 
        {
            MiniWord += EnterString[i];
        }
    }
    return SplittedString;
}

string Translate(string WordToTranslate, const map<string, string>& Dictionary) // func for Translate words to Morze
{
  string  TranslatedWord = "";
 for (int j = 0; j < WordToTranslate.length(); j++)
 {
    string fifthblank = WordToTranslate.substr(j, 1);
    TranslatedWord += Dictionary.at(fifthblank);
 }
 return TranslatedWord;
}

string UnicChecker(const vector<string>& TranslatedAllCombinations, string RNComb) // func for chech combination`s unic
{
    int SOS = 0; //ScoreOfSames
    for (string word : TranslatedAllCombinations)
    {
        if (RNComb == word) 
        {
            SOS += 1;
        }
    }
    if (SOS > 1)    
        {
            return ""; 
        }
    else
    {
        return RNComb;
    }
}

int main()
{   
    int checkofgo = 1;
    while (checkofgo)
    {
        map <string, string> Dictionary = {
            {"a", ".-"}, {"b", "-..."}, {"w", ".--"}, {"g", "--."}, {"d", "-.."}, 
            {"e", "."}, {"v", "...-"}, {"z", "--.."}, {"i", ".."}, {"j", ".---"}, 
            {"k", "-.-"}, {"l", ".-.."}, {"m", "--"}, {"n", "-."}, {"o", "---"}, 
            {"p", ".--."}, {"r", ".-."}, {"s", "..."}, {"t", "-"}, {"u", "..-"}, 
            {"f", "..-."}, {"h", "...."}, {"c", "-.-."}, {"q", "--.-"}, {"y", "-.--"}, {"x", "-..-"}
        };
        
        cout << "Enter String - ";
        string EnterString;
        getline(cin, EnterString);
        
        vector <string> SplittedString;
        for (string secblank : StringSplitter(EnterString))
        {
            SplittedString.push_back(secblank);
        }
        
        int BoolCheckOfWordLength = 1; 
        for (string thirdblank : SplittedString)
        {
            if (thirdblank.length() > 9) {
                BoolCheckOfWordLength = 0;
                break; 
            }
        }
        
        int BoolCheckOfStringLength = 1; 
        if (EnterString.length() > 100 || EnterString.length() < 1)
        {
            BoolCheckOfStringLength = 0;
        }
        
        if (!BoolCheckOfStringLength || !BoolCheckOfWordLength)
        {
            cout << "Please, enter correct string" << endl;
        }
        else
        {   
            vector<string> AllCombinations;
            for (string fourthblank : SplittedString)
            {
                for (string Combination : WordConverter(fourthblank))
                {
                    AllCombinations.push_back(Combination);
                }
            }
             vector<string> TranslatedAllCombinations;
            for (string WordToTranslate : AllCombinations)
            {
                TranslatedAllCombinations.push_back(Translate(WordToTranslate, Dictionary));
            }
            set<string> UnicCombinations;
            for (string RNComb : TranslatedAllCombinations)
            {
                string sixblank = UnicChecker(TranslatedAllCombinations, RNComb);
                if (sixblank == "")
                {
                    continue;
                }
                else
                {
                    UnicCombinations.insert(sixblank);
                }
            }
            cout << endl;
            cout << "All combinations and their Morze translation: " << endl;
            for (int outputcount = 0; outputcount < AllCombinations.size(); outputcount++)
            {
                cout << AllCombinations[outputcount] << " = " << "(" << TranslatedAllCombinations[outputcount] << ")" << endl;
            }
            cout << "Unic words: " << endl;
            for (string Output : UnicCombinations)
            {
                cout << "(" << Output << ")" << " ";
            }
            cout << endl << "____________________________________________________" << endl << "               " << "Value of unic words - " << UnicCombinations.size() << endl;
    }
    checkofgo = 0;
}
}
