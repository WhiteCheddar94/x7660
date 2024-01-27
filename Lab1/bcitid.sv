// ELEX 7660 Lab 1
// Nicholas Scott AKA "White Cheddar"
// A01255181
// Instructor: "Sweet" Bobby T

module bcitid (input logic [1:0] digit,
                output logic [3:0] idnum);

    // assign '5181' to digits 3 to 0, respectively
    always_comb
        case(digit)         
            0 : idnum = 1;  // rightmost digit
            1 : idnum = 8; 
            2 : idnum = 1;
            3 : idnum = 5;  // leftmost digit
        endcase

endmodule 
