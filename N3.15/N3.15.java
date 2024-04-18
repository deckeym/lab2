import java.util.Scanner;

public class NumberReverser {
    public static boolean reglamentCheck(int num) {
        int prevDigit = num % 10;
        num = num / 10;
        while (num != 0) {
            int currentDigit = num % 10;
            if (currentDigit <= prevDigit) {
                prevDigit = currentDigit;
                num /= 10;
            } else {
                return false;
            }
        }
        return true;
    }

    public static int numReverser(int numBlank) {
        if (reglamentCheck(numBlank)) {
            int reversedNum = 0;
            while (numBlank != 0) {
                reversedNum = reversedNum * 10 + numBlank % 10;
                numBlank /= 10;
            }
            return reversedNum;
        } else {
            return 0;
        }
    }

    public static void main(String[] args) {
        final int defaultCount = 4;
        int n = defaultCount;

        Scanner scanner = new Scanner(System.in);
        for (int i = 0; i < n; ++i) {
            int number = scanner.nextInt();
            System.out.print(numReverser(number) + " ");
        }
        System.out.println();
    }
}