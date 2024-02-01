// ELEX 7660 Ass1
// Nicholas Scott AKA "White Cheddar"
// Jan. 30th, 2024
// Instructor: Sweet Bobby T 

module shiftReg (output logic [7:0] q, 
                input logic [7:0] a, input logic [1:0] s, 
                input logic shiftIn, clk, reset_n); 

    always_ff @( posedge clk or negedge reset_n ) begin 

        if(!reset_n) 
            q <= a; // what I assume you want the reset to do 

        else begin // if active low reset not pressed

            case(s)
                0 : q <= a; // follow a
                1 : begin
                    q >>= 1; // make room for shiftIn variable 
                    q[7] <= shiftIn;    // get in there
                end
                2 : begin
                    q <<= 1; // make some room on the right side
                    q[0] <= shiftIn; // shift that thang in there 
                end
                3 : q <= q; // maintain current state
            endcase

        end

    end

endmodule 