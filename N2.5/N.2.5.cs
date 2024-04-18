using System;
using System.Collections.Generic;
using System.Linq;

namespace WordTranslator
{
    class Program
    {
        static List<string> WordConverter(string fourthblank)
        {
            List<string> ConvertedWord = new List<string>();
            char[] BlankWord = fourthblank.ToCharArray();
            Array.Sort(BlankWord);
            ConvertedWord.Add(new string(BlankWord));
            while (NextPermutation(BlankWord))
            {
                ConvertedWord.Add(new string(BlankWord));
            }
            return ConvertedWord;
        }

        static bool NextPermutation(char[] arr)
        {
            int i = arr.Length - 2;
            while (i >= 0 && arr[i] >= arr[i + 1])
            {
                i--;
            }
            if (i < 0)
            {
                return false;
            }
            int j = arr.Length - 1;
            while (arr[j] <= arr[i])
            {
                j--;
            }
            Swap(arr, i, j);
            Array.Reverse(arr, i + 1, arr.Length - i - 1);
            return true;
        }

        static void Swap(char[] arr, int i, int j)
        {
            char temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
        }

        static List<string> StringSplitter(string EnterString)
        {
            List<string> SplittedString = new List<string>();
            string[] words = EnterString.Split(' ');
            foreach (string word in words)
            {
                SplittedString.Add(word);
            }
            return SplittedString;
        }

        static string Translate(string WordToTranslate, Dictionary<string, string> Dictionary)
        {
            string TranslatedWord = "";
            foreach (char c in WordToTranslate)
            {
                string fifthblank = c.ToString();
                TranslatedWord += Dictionary[fifthblank];
            }
            return TranslatedWord;
        }

        static string UnicChecker(List<string> TranslatedAllCombinations, string RNComb)
        {
            int SOS = 0; //ScoreOfSames
            foreach (string word in TranslatedAllCombinations)
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

        static void Main(string[] args)
        {
            int checkofgo = 1;
            while (checkofgo == 1)
            {
                Dictionary<string, string> Dictionary = new Dictionary<string, string>()
                {
                    {"a", ".-"}, {"b", "-..."}, {"w", ".--"}, {"g", "--."}, {"d", "-.."},
                    {"e", "."}, {"v", "...-"}, {"z", "--.."}, {"i", ".."}, {"j", ".---"},
                    {"k", "-.-"}, {"l", ".-.."}, {"m", "--"}, {"n", "-."}, {"o", "---"},
                    {"p", ".--."}, {"r", ".-."}, {"s", "..."}, {"t", "-"}, {"u", "..-"},
                    {"f", "..-."}, {"h", "...."}, {"c", "-.-."}, {"q", "--.-"}, {"y", "-.--"}, {"x", "-..-"}
                };

                Console.Write("Enter String - ");
                string EnterString = Console.ReadLine();

                List<string> SplittedString = StringSplitter(EnterString);

                int BoolCheckOfWordLength = 1;
                foreach (string thirdblank in SplittedString)
                {
                    if (thirdblank.Length > 9)
                    {
                        BoolCheckOfWordLength = 0;
                        break;
                    }
                }

                int BoolCheckOfStringLength = 1;
                if (EnterString.Length > 100 || EnterString.Length < 1)
                {
                    BoolCheckOfStringLength = 0;
                }

                if (BoolCheckOfStringLength == 0 || BoolCheckOfWordLength == 0)
                {
                    Console.WriteLine("Please, enter correct string");
                }
                else
                {
                    List<string> AllCombinations = new List<string>();
                    foreach (string fourthblank in SplittedString)
                    {
                        foreach (string Combination in WordConverter(fourthblank))
                        {
                            AllCombinations.Add(Combination);
                        }
                    }
                    List<string> TranslatedAllCombinations = new List<string>();
                    foreach (string WordToTranslate in AllCombinations)
                    {
                        TranslatedAllCombinations.Add(Translate(WordToTranslate, Dictionary));
                    }
                    HashSet<string> UnicCombinations = new HashSet<string>();
                    foreach (string RNComb in TranslatedAllCombinations)
                    {
                        string sixblank = UnicChecker(TranslatedAllCombinations, RNComb);
                        if (sixblank == "")
                        {
                            continue;
                        }
                        else
                        {
                            UnicCombinations.Add(sixblank);
                        }
                    }
                    Console.WriteLine();
                    Console.WriteLine("All combinations and their Morze translation: ");
                    for (int outputcount = 0; outputcount < AllCombinations.Count; outputcount++)
                    {
                        Console.WriteLine(AllCombinations[outputcount] + " = " + "(" + TranslatedAllCombinations[outputcount] + ")");
                    }
                    Console.WriteLine("Unic words: ");
                    foreach (string Output in UnicCombinations)
                    {
                        Console.Write("(" + Output + ")" + " ");
                    }
                    Console.WriteLine();
                    Console.WriteLine("____________________________________________________");
                    Console.WriteLine("               " + "Value of unic words - " + UnicCombinations.Count);
                }
                checkofgo = 0;
            }
        }
    }
}