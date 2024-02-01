// ELEX 7660 Ass1
// Nicholas Scott AKA "White Cheddar"
// Jan. 30th, 2024
// Instructor: Sweet Bobby T 

`timescale 1ms/1ms

function logic check_value (int expected_value, int actual_value); // your handy lil function 

    if (expected_value != actual_value) begin
        $display("FAIL: expected value is %d => actual value is %d", expected_value, actual_value) ;
        check_value = 1;
    end else
        check_value = 0;

endfunction

module encoder_tb ; 

    // expected values, in sequence from a = 0 to a = 15
    int yExpectedValues [0:15] = '{0,0,1,1,2,2,2,2,3,3,3,3,3,3,3,3}; 
    int validExpectedValues [0:15] = '{0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};  

    // encoder outputs
    logic [1:0] y; 
    logic valid; 

    logic [3:0] a = 0; // encoder input 

    logic tb_fail = 0; 
    logic clk = 1; 

    encoder dut (.*); 

    initial begin 

        for (int i = 0; i <=15; i++) begin 
            
            a = i; // increment a from 0 to 15
            repeat(1) @(negedge clk); // allow some time for output to stabilize

            // check both outputs
            tb_fail |= check_value (yExpectedValues[i], y);
            tb_fail |= check_value (validExpectedValues[i], valid);
            
            repeat(1) @(negedge clk); // allow some time again 

        end  

        if (tb_fail)
            $display("DUMBASS!") ;
        else
            $display("YEEEEEEAH BOIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII") ;
        $stop;

    end 

    // 1 Hz clock
    always
        #1000ms clk = ~clk ; 

endmodule 
    








