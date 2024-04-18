function reglamentCheck(num) {
    let prevDigit = num % 10;
    num = Math.floor(num / 10);
    while (num !== 0) {
      let currentDigit = num % 10;
      if (currentDigit <= prevDigit) {
        prevDigit = currentDigit;
        num = Math.floor(num / 10);
      } else {
        return false;
      }
    }
    return true;
  }
  
  function numReverser(numBlank) {
    if (reglamentCheck(numBlank)) {
      let reversedNum = 0;
      while (numBlank !== 0) {
        reversedNum = reversedNum * 10 + numBlank % 10;
        numBlank = Math.floor(numBlank / 10);
      }
      return reversedNum;
    } else {
      return 0;
    }
  }
  
  const defaultCount = 4;
  let n = defaultCount;
  
  for (let i = 0; i < n; ++i) {
    let number = parseInt(prompt("Enter a number:"));
    console.log(numReverser(number) + " ");
  }
  console.log();