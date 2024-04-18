
import java.util.*;

public class WordConverter {
    public static List<String> convertWord(String word) {
        List<String> convertedWord = new ArrayList<>();
        char[] charArray = word.toCharArray();
        Arrays.sort(charArray);
        String blankWord = new String(charArray);
        convertedWord.add(blankWord);
        while (nextPermutation(charArray)) {
            blankWord = new String(charArray);
            convertedWord.add(blankWord);
        }
        return convertedWord;
    }

    public static boolean nextPermutation(char[] array) {
        int i = array.length - 2;
        while (i >= 0 && array[i] >= array[i + 1]) {
            i--;
        }
        if (i < 0) {
            return false;
        }
        int j = array.length - 1;
        while (array[j] <= array[i]) {
            j--;
        }
        swap(array, i, j);
        reverse(array, i + 1, array.length - 1);
        return true;
    }

    public static void swap(char[] array, int i, int j) {
        char temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }

    public static void reverse(char[] array, int start, int end) {
        while (start < end) {
            swap(array, start, end);
            start++;
            end--;
        }
    }

    public static List<String> splitString(String inputString) {
        List<String> splittedString = new ArrayList<>();
        String[] words = inputString.split(" ");
        for (String word : words) {
            splittedString.add(word);
        }
        return splittedString;
    }

    public static String translate(String wordToTranslate, Map<String, String> dictionary) {
        StringBuilder translatedWord = new StringBuilder();
        for (int i = 0; i < wordToTranslate.length(); i++) {
            String letter = String.valueOf(wordToTranslate.charAt(i));
            translatedWord.append(dictionary.get(letter));
        }
        return translatedWord.toString();
    }

    public static String checkUniqueness(List<String> translatedAllCombinations, String combination) {
        int scoreOfSames = 0;
        for (String word : translatedAllCombinations) {
            if (combination.equals(word)) {
                scoreOfSames++;
            }
        }
        if (scoreOfSames > 1) {
            return "";
        } else {
            return combination;
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Map<String, String> dictionary = new HashMap<>();
        dictionary.put("a", ".-");
        dictionary.put("b", "-...");
        dictionary.put("w", ".--");
        dictionary.put("g", "--.");
        dictionary.put("d", "-..");
        dictionary.put("e", ".");
        dictionary.put("v", "...-");
        dictionary.put("z", "--..");
        dictionary.put("i", "..");
        dictionary.put("j", ".---");
        dictionary.put("k", "-.-");
        dictionary.put("l", ".-..");
        dictionary.put("m", "--");
        dictionary.put("n", "-.");
        dictionary.put("o", "---");
        dictionary.put("p", ".--.");
        dictionary.put("r", ".-.");
        dictionary.put("s", "...");
        dictionary.put("t", "-");
        dictionary.put("u", "..-");
        dictionary.put("f", "..-.");
        dictionary.put("h", "....");
        dictionary.put("c", "-.-.");
        dictionary.put("q", "--.-");
        dictionary.put("y", "-.--");
        dictionary.put("x", "-..-");

        int checkOfGo = 1;
        while (checkOfGo == 1) {
            System.out.print("Enter String - ");
            String enterString = scanner.nextLine();

            List<String> splittedString = splitString(enterString);

            int boolCheckOfWordLength = 1;
            for (String word : splittedString) {
                if (word.length() > 9) {
                    boolCheckOfWordLength = 0;
                    break;
                }
            }

            int boolCheckOfStringLength = 1;
            if (enterString.length() > 100 || enterString.length() < 1) {
                boolCheckOfStringLength = 0;
            }

            if (boolCheckOfStringLength == 0 || boolCheckOfWordLength == 0) {
                System.out.println("Please, enter correct string");
            } else {
                List<String> allCombinations = new ArrayList<>();
                for (String word : splittedString) {
                    for (String combination : convertWord(word)) {
                        allCombinations.add(combination);
                    }
                }

                List<String> translatedAllCombinations = new ArrayList<>();
                for (String wordToTranslate : allCombinations) {
                    translatedAllCombinations.add(translate(wordToTranslate, dictionary));
                }

                Set<String> uniqueCombinations = new HashSet<>();
                for (String combination : translatedAllCombinations) {
                    String uniqueCombination = checkUniqueness(translatedAllCombinations, combination);
                    if (!uniqueCombination.equals("")) {
                        uniqueCombinations.add(uniqueCombination);
                    }
                }

                System.out.println();
                System.out.println("All combinations and their Morze translation: ");
                for (int i = 0; i < allCombinations.size(); i++) {
                    System.out.println(allCombinations.get(i) + " = " + "(" + translatedAllCombinations.get(i) + ")");
                }

                System.out.println("Unique words: ");
                for (String output : uniqueCombinations) {
                    System.out.print("(" + output + ") ");
                }

                System.out.println();
                System.out.println("____________________________________________________");
                System.out.println("Value of unique words - " + uniqueCombinations.size());
            }
            checkOfGo = 0;
        }
    }
}
