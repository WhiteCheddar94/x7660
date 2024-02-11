// ELEX 7660 Lab 4
// Nicholas Scott AKA "White Cheddar"
// A01255181
// Feb. 4th, 2024
// Instructor: Sweet Bobby T 

module adcinterface( 
    input logic clk, reset_n,   // clock and reset 
    input logic [2:0] chan,     // ADC channel to sample 
    output logic [11:0] result, // ADC result 
     
    // ltc2308 signals 
    output logic ADC_CONVST, ADC_SCK, ADC_SDI, 
    input logic ADC_SDO  
);

    logic [5:0] word; // word which tells ADC which channel we want
    logic [3:0] count; // a count bit that counts 
    logic [11:0] tempResult; // a temp variable to store result 

    always_comb begin 

        // activate ADC clock for 12 clock cycles 
        ADC_SCK = ((count >= 2) && (count <= 13)) ? clk : 1'b0;

        // Set config word based on chan input 
        case (chan)
            0 : word = 6'b100010; 
            1 : word = 6'b110010;
            2 : word = 6'b100110; 
            3 : word = 6'b110110; 
            4 : word = 6'b101010; 
            5 : word = 6'b111010; 
            6 : word = 6'b101110; 
            7 : word = 6'b111110; 
        endcase
    end 

    always_ff @( negedge clk or negedge reset_n ) begin     
        if (~reset_n)  
            count <= 0; 
        else   
            count <= count + 1;  // automatically rolls over at 16

    end

    always_ff @( negedge clk or negedge reset_n ) begin     
        if (~reset_n) begin 
            ADC_CONVST <= 1; 
            ADC_SDI <= 0;  
        end 
        else begin
            case (count)
                0 : ADC_CONVST <= 0; // conversion start signal
                // send config word one bit at a time
                1 : ADC_SDI <= word[5]; 
                2 : ADC_SDI <= word[4]; 
                3 : ADC_SDI <= word[3]; 
                4 : ADC_SDI <= word[2]; 
                5 : ADC_SDI <= word[1]; 
                6 : ADC_SDI <= word[0]; 
                15 : ADC_CONVST <= 1; // conversion end 
                default : ADC_SDI <= 0; 
            endcase      
        end
    end 

    always_ff @(posedge clk or negedge reset_n)
        if(~reset_n)
            result <= 0;
        else 
            case (count)
                // receive ADC result one bit at a time
                2 : tempResult[11] <= ADC_SDO; 
                3 : tempResult[10] <= ADC_SDO; 
                4 : tempResult[9] <= ADC_SDO; 
                5 : tempResult[8] <= ADC_SDO; 
                6 : tempResult[7] <= ADC_SDO; 
                7 : tempResult[6] <= ADC_SDO; 
                8 : tempResult[5] <= ADC_SDO; 
                9 : tempResult[4] <= ADC_SDO; 
                10 : tempResult[3] <= ADC_SDO; 
                11 : tempResult[2] <= ADC_SDO; 
                12 : tempResult[1] <= ADC_SDO; 
                13 : tempResult[0] <= ADC_SDO;
                14 : result <= tempResult; // assign result
                default: result <= result; 
            endcase

endmodule 