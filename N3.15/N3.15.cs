using System;

namespace ReverseNumber
{
    class Program
    {
        static bool ReglamentCheck(int num)
        {
            int prevDigit = num % 10;
            num = num / 10;
            while (num != 0)
            {
                int currentDigit = num % 10;
                if (currentDigit <= prevDigit)
                {
                    prevDigit = currentDigit;
                    num /= 10;
                }
                else
                {
                    return false;
                }
            }
            return true;
        }

        static int NumReverser(int numblank)
        {
            if (ReglamentCheck(numblank))
            {
                int reversedNum = 0;
                while (numblank != 0)
                {
                    reversedNum = reversedNum * 10 + numblank % 10;
                    numblank /= 10;
                }
                return reversedNum;
            }
            else
            {
                return 0;
            }
        }

        static void Main(string[] args)
        {
            const int defaultCount = 4;
            int n = defaultCount;

            for (int i = 0; i < n; ++i)
            {
                int number = Convert.ToInt32(Console.ReadLine());
                Console.Write(NumReverser(number) + " ");
            }
            Console.WriteLine();
        }
    }
}