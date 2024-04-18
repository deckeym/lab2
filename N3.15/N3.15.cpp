#include <iostream>

using namespace std;

bool ReglamentCheck(int num)
{
    int PrevDigit = num % 10;
    num = num / 10;
    while (num != 0)
    {
        int CurrentDigit = num % 10;
        if (CurrentDigit <= PrevDigit) // Изменено условие
        {
            PrevDigit = CurrentDigit;
            num /= 10;
        }
        else
        {
            return false;
        }
    }
    return true;
}

int NumReverser(int numblank)
{
    if (ReglamentCheck(numblank))
    {
        int ReversedNum = 0;
        while (numblank != 0)
        {
            ReversedNum = ReversedNum * 10 + numblank % 10;
            numblank /= 10;
        }
        return ReversedNum;
    }
    else
    {
        return 0;
    }
}

int main()
{
    int n;
    cout << "Enter the number of numbers : ";
    cin >> n;
    
    if (n > 0)
    {
        cout << "Enter " << n << " numbers:" << endl;
        
        for (int i = 0; i < n; ++i)
        {
            int number;
            cin >> number;
            cout << NumReverser(number);
            if (i < n - 1) // Проверяем, нужно ли выводить пробел
            {
                cout << " ";
            }
        }
        cout << endl;
    }

    return 0;
}