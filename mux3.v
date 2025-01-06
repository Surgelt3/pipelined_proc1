module mux3 #(parameter WIDTH = 32) (
    input [WIDTH-1:0] in0, in1, in2,
    input [1:0] sel,
    output [WIDTH-1:0] out
);

    assign out = sel[1] ? in2 : (sel[0] ? in1 : in0);

endmodule