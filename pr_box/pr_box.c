#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/**
 * PR Box Simulation (Generalized Probabilistic Theory)
 * Logic: (a + b) % 2 = (x * y)
 * This simulates a correlation stronger than Quantum Logic (Tsirelson's Bound).
 */

typedef struct {
    int a; // Alice's output
    int b; // Bob's output
} PRBoxResult;

PRBoxResult simulate_pr_box(int x, int y) {
    PRBoxResult result;

    // Alice's output 'a' is locally random (0 or 1).
    // This maintains the 'No-Signaling' principle.
    result.a = rand() % 2;

    // The PR constraint: a XOR b = x AND y
    // Solving for Bob's output: b = a XOR (x AND y)
    result.b = (result.a ^ (x & y));

    return result;
}

int main() {
    // Seed the RNG for different results each run
    srand((unsigned int)time(NULL));

    int inputs[4][2] = {{0,0}, {0,1}, {1,0}, {1,1}};

    printf("--- PR Box (Post-Quantum) Simulation ---\n");
    printf("Inputs (x,y) | Outputs (a,b) | (a+b)%%2 == x*y\n");
    printf("--------------------------------------------\n");

    for (int i = 0; i < 4; i++) {
        int x = inputs[i][0];
        int y = inputs[i][1];

        PRBoxResult res = simulate_pr_box(x, y);

        // Verification of the super-quantum logic
        int correlation = (res.a ^ res.b);
        int target = (x & y);

        printf("  (%d, %d)     |    (%d, %d)     |      %s\n",
               x, y, res.a, res.b,
               (correlation == target) ? "VALID" : "INVALID");
    }

    return 0;
}
