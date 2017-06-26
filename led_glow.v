module led_glow(clk, out);
	parameter NOUT = 55;
	input clk;
	output [NOUT:0] out;

	reg [30:0] cnt;
	wire [NOUT:0] out;

	always @(posedge clk) begin
		cnt = cnt+1;
	end

	wire [3:0] PWM_input1 = cnt[24] ? cnt[23:20] : ~cnt[23:20];    // ramp the PWM input up and down

	reg [4:0] PWM1;
	always @(posedge clk) PWM1 <= PWM1[3:0]+PWM_input1;

	// http://www.rhinocerus.net/forum/lang-verilog/167265-sized-genvar.html
	genvar i;
	generate
	for (i=6'd0;i<(NOUT+6'd1);i=i+6'd1)
	begin : foo
	  assign out[i] = (i[5:0]==cnt[30:25]) ? (~PWM1[4]) : 1'd0;
	end
	endgenerate

endmodule


