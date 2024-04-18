import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter a string: ");
        String line = scanner.nextLine();
        int globalCount = 0;
        String finalRow = stringFixer(line, globalCount);
        System.out.println("\nFixed string: " + finalRow);
        System.out.println("Number of changes: " + globalCount);
    }

    public static String stringFixer(String line, int globalCount) {
        StringBuilder workRow = new StringBuilder(line);
        int count = 0;
        for (int i = 0; i < workRow.length() - 1; i++) {
            int codeSymbol = (int) workRow.charAt(i);
            codeSymbol++;
            char nextSymbol = (char) codeSymbol;
            if (workRow.charAt(i) == workRow.charAt(i + 1)) {
                count++;
            }
            if (count == 2) {
                workRow.insert(i + 1, nextSymbol);
                count = 0;
                globalCount++;
            }
        }
        return workRow.toString();
    }
}