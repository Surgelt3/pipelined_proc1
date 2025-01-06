module instruction_memory(
    input [31:0] address,
    output [31:0] read_data
);
      
    reg [31:0] RAM[63:0];

    initial begin
        $readmemh("C:/\Users/\lucas/\Desktop/\Digital/\single_cycle/\riscvtest.txt", RAM);
    end

    assign read_data = RAM[address[31:2]];
    
    always @(*) begin 
        $monitor("Read Data = %b", read_data); 
    end

endmodule