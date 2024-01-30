// ELEX 7660 Lab 3 
// Nicholas Scott AKA "White Cheddar"
// January 28th, 2024
// Instructor: Sweet Bobby T

`timescale 1ms/1ms

function logic check_value (int expected_value, int actual_value);

    if (expected_value != actual_value) begin
        $display("FAIL: expected value is %d => actual value is %d", expected_value, actual_value) ;
        check_value = 1;
    end else
        check_value = 0;

endfunction

module enc2freq_tb ; 

    logic cw = 0; 
    logic ccw = 0;
    logic reset_n = 1; 
    logic clk = 1; 
    logic [31:0] freq;  

    logic [10:0][10:0] CMajor = '{0,0,524,491,437,393,349,328,295,262,0};
    logic tb_fail = 0; 

    enc2freq dut (.*); 

    initial begin

        // reset
        reset_n = 0; 
        repeat(2) @(negedge clk) ; 
        reset_n = 1;

        // ensure frequency starts at 0 after reset is pressed
        tb_fail = check_value (CMajor[0], freq); 

        // simulate full cw rotation 
        for (int i = 1 ; i<=8 ; i++) begin

            // 4 cw pulses
            for (int i = 0; i<4; i++)begin 
                cw = 1; 
                repeat(1) @(negedge clk); 
                cw = 0;
                repeat(1) @(negedge clk); 
            end 

            tb_fail |= check_value (CMajor[i], freq); 
        end 

        // simulate full ccw rotation 
        for (int i = 8 ; i>=0 ; i--) begin

            tb_fail |= check_value (CMajor[i], freq); 

            // 4 ccw pulses
            for (int i = 0; i<4; i++)begin 
                ccw = 1; 
                repeat(1) @(negedge clk); 
                ccw = 0;
                repeat(1) @(negedge clk); 
            end 
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
