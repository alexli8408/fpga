module full_adder_4bit (
	input [3:0] hex_A,
	input [3:0] hex_B,
	input cin,
	output [3:0] hex_sum,
	output cout
	);
	
	wire c0, c1, c2;
	
	full_adder_1bit FA0 (
		.input_A(hex_A[0]),
		.input_B(hex_B[0]),
		.carry_in(cin),
		.sum_out(hex_sum[0]),
		.carry_out(c0)
	);
	
	full_adder_1bit FA1 (
		.input_A(hex_A[1]),
		.input_B(hex_B[1]),
		.carry_in(c0),
		.sum_out(hex_sum[1]),
		.carry_out(c1)
	);
	
	full_adder_1bit FA2 (
		.input_A(hex_A[2]),
		.input_B(hex_B[2]),
		.carry_in(c1),
		.sum_out(hex_sum[2]),
		.carry_out(c2)
	);
	
	full_adder_1bit FA3 (
		.input_A(hex_A[3]),
		.input_B(hex_B[3]),
		.carry_in(c2),
		.sum_out(hex_sum[3]),
		.carry_out(cout)
	);

endmodule

