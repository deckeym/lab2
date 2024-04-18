function StringFixer(Line, Globalcount) {
    let WorkRow = Line;
    let count = 0;
    for (let i = 0; i < WorkRow.length - 1; i++) {
        let code_symbol = WorkRow.charCodeAt(i);
        code_symbol++;
        let next_symbol = String.fromCharCode(code_symbol);
        if (WorkRow[i] === WorkRow[i + 1]) {
            count++;
        }
        if (count === 2) {
            WorkRow = WorkRow.substring(0, i + 1) + next_symbol + WorkRow.substring(i + 1);
            count = 0;
            Globalcount[0]++;
        }
    }
    return WorkRow;
}

function main() {
    const Globalcount = [0];
    console.log("Enter row, please - ");
    const readline = require('readline');
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    rl.question('', (Line) => {
        const FinalRow = StringFixer(Line, Globalcount);
        console.log("\nFixed row - " + FinalRow + "\nValue of changes - " + Globalcount[0]);
        rl.close();
    });
}

main();
