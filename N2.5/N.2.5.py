from itertools import permutations

def word_converter(word):
    sorted_word = ''.join(sorted(word))
    return set(''.join(p) for p in permutations(sorted_word))

def string_splitter(enter_string):
    return enter_string.split()

def translate(word_to_translate, dictionary):
    return ''.join(dictionary[char] for char in word_to_translate)

def unic_checker(translated_all_combinations, rn_comb):
    return rn_comb if translated_all_combinations.count(rn_comb) == 1 else ""

def main():
    dictionary = {
        "a": ".-", "b": "-...", "w": ".--", "g": "--.", "d": "-..",
        "e": ".", "v": "...-", "z": "--..", "i": "..", "j": ".---",
        "k": "-.-", "l": ".-..", "m": "--", "n": "-.", "o": "---",
        "p": ".--.", "r": ".-.", "s": "...", "t": "-", "u": "..-",
        "f": "..-.", "h": "....", "c": "-.-.", "q": "--.-", "y": "-.--", "x": "-..-"
    }

    while True:
        print("Enter String - ")
        enter_string = input()

        if len(enter_string) > 100 or len(enter_string) < 1 or any(len(word) > 9 for word in enter_string.split()):
            print("Please, enter correct string")
            continue

        all_combinations = set()
        for word in string_splitter(enter_string):
            all_combinations.update(word_converter(word))

        translated_all_combinations = [translate(word, dictionary) for word in all_combinations]

        unic_combinations = set(unic_checker(translated_all_combinations, comb) for comb in translated_all_combinations)
        unic_combinations.discard("")

        print("\nAll combinations and their Morze translation: ")
        for word, morze in zip(all_combinations, translated_all_combinations):
            print(f"{word} = ({morze})")

        print("Unic words: ")
        for output in unic_combinations:
            print(f"({output}) ", end="")

        print(f"\n\nValue of unic words - {len(unic_combinations)}")
        break

if __name__ == "__main__":
    main()