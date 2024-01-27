// ELEX 7660 Lab 1
// Nicholas Scott AKA "White Cheddar"
// A01255181
// Instructor: "Sweet" Bobby T

module decode2 (input logic [1:0] digit,
                output logic [3:0] ct); 

    // 'ct' enables one digit of 7-segment display based on 'digit' input
    always_comb
        case(digit)
            0 : ct = 'b1110;    // righmost digit enabled
            1 : ct = 'b1101;
            2 : ct = 'b1011;
            3 : ct = 'b0111;    // leftmost digit enabled 
        endcase
        
endmodule
