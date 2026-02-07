module LogicalStep_Lab2_top
(
	input				rst_n,		//reset in
	input          clkin_50,	//clock in
	input		[7:0]	sw,
	input		[3:0]	pb_n,

	output	[7:0]	leds,
	output	[6:0]	seg7_data,
	output			seg7_char1,
	output			seg7_char2
);

//these are used as intermediate signals
	wire 	[3:0] hex_A, hex_B;
	wire	[6:0] seg7_A, seg7_B;
	wire [3:0] pb;
	wire [3:0] adder_sum;
	wire adder_cout;
	wire [3:0] carry_display;
	wire [3:0] seg7_A_input;
	wire [3:0] seg7_B_input;

	
// wire assignments
	assign hex_A = sw[3:0];
	assign hex_B = sw[7:4];
	assign carry_display = {3'b000, adder_cout};
	assign leds[7:4] = 4'b0000;

	
//module instantiations are here
//
//	SevenSegment u1 (
//		.hex      (hex_A), 
//		.sevenseg (seg7_A)
//	);
//
//	SevenSegment u2 (
//		.hex      (hex_B), 
//		.sevenseg (seg7_B)
//	);

	segment7_mux u3 (
		.clk  (clkin_50),
		.din2 (seg7_A), 
		.din1 (seg7_B),
		.dout (seg7_data),
		.dig2 (seg7_char2), 
		.dig1 (seg7_char1)
	);
	
	pb_inverters u4 (
		.pbin (pb_n),
		.pbout (pb)
	);
	
	logic_proc u5 (
		.logic_in1 (hex_B),
		.logic_in0 (hex_A),
		.select (pb[1:0]),
		.logic_out (leds[3:0])
	);
	
	full_adder_4bit adder_inst (
		.hex_A(hex_A),
		.hex_B(hex_B),
		.cin(1'b0),
		.hex_sum(adder_sum),
		.cout(adder_cout)
	);
 
	mux_4bit_2_to_1 mux_A (
		.din_A(hex_A),
		.din_B(adder_sum),
		.selector(pb[2]),
		.dout(seg7_A_input)
	);
	
	mux_4bit_2_to_1 mux_B (
		.din_A(hex_B),
		.din_B(carry_display),
		.selector(pb[2]),
		.dout(seg7_B_input)
	);
	
	SevenSegment seg7_A_inst (
		.hex(seg7_A_input),
		.sevenseg(seg7_A)
	);
	
	SevenSegment seg7_B_inst (
		.hex(seg7_B_input),
		.sevenseg(seg7_B)
	);
 
endmodule

	