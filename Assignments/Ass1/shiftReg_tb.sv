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

module shiftReg_tb; 
    
    logic [7:0] q; 
    logic [7:0] a = 'b00001000; // almost palindrominc 
    logic [1:0] s; 
    logic reset_n = 1; 
    logic clk = 1; 
    logic shiftIn; 
    logic tb_fail = 0; 

    // sequence of expected outputs
    logic [7:0] qExpectedValues[0:6] = '{'b00001000, 'b00000100,'b10000010,'b00000100,'b00001001,'b00001001,'b00001000};

    shiftReg dut (.*); 

    initial begin 

        // set q to a 
        s = 0; 
        repeat(1) @(negedge clk); 
        tb_fail |= check_value (qExpectedValues[0], q); 
        //repeat(1) @(negedge clk); 

        // right shift in a 0
        s = 1; 
        shiftIn = 0; 
        repeat(1) @(negedge clk); 
        tb_fail |= check_value (qExpectedValues[1], q); 
        //repeat(1) @(negedge clk); 

        // right shift in a 1
        s = 1; 
        shiftIn = 1; 
        repeat(1) @(negedge clk); 
        tb_fail |= check_value (qExpectedValues[2], q); 
        //repeat(1) @(negedge clk);

        // left shift in a 0
        s = 2; 
        shiftIn = 0; 
        repeat(1) @(negedge clk); 
        tb_fail |= check_value (qExpectedValues[3], q); 
        //repeat(1) @(negedge clk);

        // left shift in a 1
        s = 2; 
        shiftIn = 1; 
        repeat(1) @(negedge clk); 
        tb_fail |= check_value (qExpectedValues[4], q); 
        //repeat(1) @(negedge clk);

        // maintain q 
        s = 3; 
        repeat(1) @(negedge clk); 
        tb_fail |= check_value (qExpectedValues[5], q); 
        //repeat(1) @(negedge clk);

        // reset
        reset_n = 0; 
        repeat(1) @(negedge clk); 
        tb_fail |= check_value (qExpectedValues[6], q); 
        //repeat(1) @(negedge clk);

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