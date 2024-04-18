function wordConverter(fourthBlank) {
    const convertedWord = [];
    let blankWord = fourthBlank;
    blankWord = blankWord.split('').sort().join('');
    convertedWord.push(blankWord);
    while (nextPermutation(blankWord)) {
      convertedWord.push(blankWord);
    }
    return convertedWord;
  }
  
  function nextPermutation(word) {
    let i = word.length - 2;
    while (i >= 0 && word[i] >= word[i + 1]) {
      i--;
    }
    if (i < 0) {
      return false;
    }
    let j = word.length - 1;
    while (word[j] <= word[i]) {
      j--;
    }
    swap(word, i, j);
    reverse(word, i + 1);
    return true;
  }
  
  function swap(word, i, j) {
    const temp = word[i];
    word[i] = word[j];
    word[j] = temp;
  }
  
  function reverse(word, start) {
    let i = start;
    let j = word.length - 1;
    while (i < j) {
      swap(word, i, j);
      i++;
      j--;
    }
  }
  
  function stringSplitter(enterString) {
    const splittedString = [];
    let miniWord = '';
    for (let i = 0; i < enterString.length; i++) {
      if (enterString[i] === ' ') {
        splittedString.push(miniWord);
        miniWord = '';
      } else if (i === enterString.length - 1) {
        miniWord += enterString[i];
        splittedString.push(miniWord);
      } else {
        miniWord += enterString[i];
      }
    }
    return splittedString;
  }
  
  function translate(wordToTranslate, dictionary) {
    let translatedWord = '';
    for (let j = 0; j < wordToTranslate.length; j++) {
      const fifthBlank = wordToTranslate.substr(j, 1);
      translatedWord += dictionary[fifthBlank];
    }
    return translatedWord;
  }
  
  function unicChecker(translatedAllCombinations, rnComb) {
    let scoreOfSames = 0;
    for (const word of translatedAllCombinations) {
      if (rnComb === word) {
        scoreOfSames += 1;
      }
    }
    if (scoreOfSames > 1) {
      return '';
    } else {
      return rnComb;
    }
  }
  
  function main() {
    const dictionary = {
      a: '.-',
      b: '-...',
      w: '.--',
      g: '--.',
      d: '-..',
      e: '.',
      v: '...-',
      z: '--..',
      i: '..',
      j: '.---',
      k: '-.-',
      l: '.-..',
      m: '--',
      n: '-.',
      o: '---',
      p: '.--.',
      r: '.-.',
      s: '...',
      t: '-',
      u: '..-',
      f: '..-.',
      h: '....',
      c: '-.-.',
      q: '--.-',
      y: '-.--',
      x: '-..-',
    };
  
    let checkOfGo = 1;
    while (checkOfGo) {
      const enterString = prompt('Enter String - ');
  
      const splittedString = stringSplitter(enterString);
  
      let boolCheckOfWordLength = 1;
      for (const thirdBlank of splittedString) {
        if (thirdBlank.length > 9) {
          boolCheckOfWordLength = 0;
          break;
        }
      }
  
      let boolCheckOfStringLength = 1;
      if (enterString.length > 100 || enterString.length < 1) {
        boolCheckOfStringLength = 0;
      }
  
      if (!boolCheckOfStringLength || !boolCheckOfWordLength) {
        console.log('Please, enter correct string');
      } else {
        const allCombinations = [];
        for (const fourthBlank of splittedString) {
          for (const combination of wordConverter(fourthBlank)) {
            allCombinations.push(combination);
          }
        }
  
        const translatedAllCombinations = [];
        for (const wordToTranslate of allCombinations) {
          translatedAllCombinations.push(translate(wordToTranslate, dictionary));
        }
  
        const unicCombinations = new Set();
        for (const rnComb of translatedAllCombinations) {
          const sixBlank = unicChecker(translatedAllCombinations, rnComb);
          if (sixBlank === '') {
            continue;
          } else {
            unicCombinations.add(sixBlank);
          }
        }
  
        console.log('\nAll combinations and their Morze translation:');
        for (let outputCount = 0; outputCount < allCombinations.length; outputCount++) {
          console.log(`${allCombinations[outputCount]} = (${translatedAllCombinations[outputCount]})`);
        }
  
        console.log('Unic words:');
        for (const output of unicCombinations) {
          console.log(`(${output})`);
        }
  
        console.log('____________________________________________________');
        console.log(`Value of unic words - ${unicCombinations.size}`);
      }
      checkOfGo = 0;
    }
  }
  
  main();