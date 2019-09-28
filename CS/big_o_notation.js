// @ notes
    // Solutions
    // first solution
    function addUpTo(n) {
        let total = 0;
        for (let i = 1; i <= n; i++) {
            total += i;
        }
        return total;    
    }

    let t1 = performance.now();
    console.log(addUpTo(1000000)); // 0.108 seconds
    let t2 = performance.now();
    console.log(`Time Elapsed: ${(t2 - t1) / 1000} seconds.`);
    
    console.log(addUpTo(1000000000)); // 1.081 seconds

    // second solution
    function addUpTo2(n) {
        return n * (n + 1) / 2;    
    }

    console.log(addUpTo2(1000000000)); // 0.104 seconds
    console.log(addUpTo2(1000000)); // 0.104 seconds