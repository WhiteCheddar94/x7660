// ELEX 7660 Ass1
// Nicholas Scott AKA "White Cheddar"
// Jan. 30th, 2024
// Instructor: Sweet Bobby T 

module encoder (output logic [1:0] y, 
                output logic valid, 
                input logic [3:0] a); 
            
    always_comb begin 
        // prepare for a case statement 
        case (a)
            0 : begin   
                y = 0; 
                valid = 0; 
            end 
            1 : begin 
                y = 0; 
                valid = 1; 
            end 
            2, 3 : begin 
                y = 1; 
                valid = 1; 
            end 
            4, 5, 6, 7 : begin 
                y = 2; 
                valid = 1; 
            end 
            8, 9, 10, 11, 12, 13, 14, 15 : begin 
                y = 3; 
                valid = 1; 
            end
        endcase 
    end 
endmodule 

