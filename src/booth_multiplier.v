module booth_multiplier(
	input			clk,
	input			rst_n,
	input [31:0]	data1,
	input [31:0]	data2,
	// output[63:0]	pp0		,
	// output[63:0]	pp1		,
	// output[63:0]	pp2		,
	// output[63:0]	pp3		,
	// output[63:0]	pp4		,
	// output[63:0]	pp5		,
	// output[63:0]	pp6		,
	// output[63:0]	pp7		,
	// output[63:0]	pp8		,
	// output[63:0]	pp9		,
	// output[63:0]	pp10	,
	// output[63:0]	pp11	,
	// output[63:0]	pp12	,
	// output[63:0]	pp13	,
	// output[63:0]	pp14	,
	// output[63:0]	pp15	
	output [63:0] 	res
);
	wire[15:0]        set0;//0
	wire[15:0]        inv;//负数
	wire[15:0]    	  X2;//乘2
	wire[63:0]	pp0	;		
	wire[63:0]	pp1	;		
	wire[63:0]	pp2	;		
	wire[63:0]	pp3	;		
	wire[63:0]	pp4	;		
	wire[63:0]	pp5	;		
	wire[63:0]	pp6	;		
	wire[63:0]	pp7	;		
	wire[63:0]	pp8	;		
	wire[63:0]	pp9	;		
	wire[63:0]	pp10;		
	wire[63:0]	pp11;		
	wire[63:0]	pp12;		
	wire[63:0]	pp13;		
	wire[63:0]	pp14;		
	wire[63:0]	pp15;		





 booth_ctrl u_booth_ctrl(
	.A		(data2),
	.set0	(set0),
	.inv	(inv),
	.X2     (X2)
);
pp_generator u_pp_generator(
	.clk	(clk),
	.rst_n	(rst_n),
	.data_i	(data1),
	.set0	(set0),	
	.inv	(inv),	
	.X2		(X2),
	.pp0	(pp0),
	.pp1	(pp1),
	.pp2	(pp2),
	.pp3	(pp3),
	.pp4	(pp4),
	.pp5	(pp5),
	.pp6	(pp6),
	.pp7	(pp7),
	.pp8	(pp8),
	.pp9	(pp9),
	.pp10	(pp10),
	.pp11	(pp11),
	.pp12	(pp12),
	.pp13	(pp13),
	.pp14	(pp14),
	.pp15	(pp15)
);
	wire[63:0]	c0_stage1,c1_stage1,c2_stage1,c3_stage1;
	wire[63:0]	s0_stage1,s1_stage1,s2_stage1,s3_stage1;
	reg[63:0]	c0_stage1_r,c1_stage1_r,c2_stage1_r,c3_stage1_r;
	reg[63:0]	s0_stage1_r,s1_stage1_r,s2_stage1_r,s3_stage1_r;

//stage1
pp_compressor4_2 pp_compressor4_2_s10(
	.i1	(pp0),
	.i2	(pp1),
	.i3	(pp2),
	.i4	(pp3),
	.C	(c0_stage1),
	.S	(s0_stage1)
);
pp_compressor4_2 pp_compressor4_2_s11(
	.i1	(pp4),
	.i2	(pp5),
	.i3	(pp6),
	.i4	(pp7),
	.C	(c1_stage1),
	.S	(s1_stage1)
);
pp_compressor4_2 pp_compressor4_2_s12(
	.i1	(pp8),
	.i2	(pp9),
	.i3	(pp10),
	.i4	(pp11),
	.C	(c2_stage1),
	.S	(s2_stage1)
);
pp_compressor4_2 pp_compressor4_2_s13(
	.i1	(pp12),
	.i2	(pp13),
	.i3	(pp14),
	.i4	(pp15),
	.C	(c3_stage1),
	.S	(s3_stage1)
);
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			c0_stage1_r <= 'b0;
			c1_stage1_r <= 'b0;
			c2_stage1_r <= 'b0;
			c3_stage1_r <= 'b0;
			s0_stage1_r <= 'b0;
			s1_stage1_r <= 'b0;
			s2_stage1_r <= 'b0;
			s3_stage1_r <= 'b0;	
		end
		else begin
			c0_stage1_r <= c0_stage1;
			c1_stage1_r <= c1_stage1;
			c2_stage1_r <= c2_stage1;
			c3_stage1_r <= c3_stage1;
			s0_stage1_r <= s0_stage1;
			s1_stage1_r <= s1_stage1;
			s2_stage1_r <= s2_stage1;
			s3_stage1_r <= s3_stage1;	
		end
	end
	wire[63:0]	c0_stage2,c1_stage2;
	wire[63:0]	s0_stage2,s1_stage2;
	reg [63:0]	c0_stage2_r,c1_stage2_r;
	reg [63:0]	s0_stage2_r,s1_stage2_r;

//stage 2
pp_compressor4_2 pp_compressor4_2_s20(
	.i1	(c0_stage1_r),
	.i2	(s0_stage1_r),
	.i3	(c1_stage1_r),
	.i4	(s1_stage1_r),
	.C	(c0_stage2),
	.S	(s0_stage2)
);
pp_compressor4_2 pp_compressor4_2_s21(
	.i1	(c2_stage1_r),
	.i2	(s2_stage1_r),
	.i3	(c3_stage1_r),
	.i4	(s3_stage1_r),
	.C	(c1_stage2),
	.S	(s1_stage2)
);
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			c0_stage2_r <= 'b0;
			c1_stage2_r <= 'b0;
			s0_stage2_r <= 'b0;
			s1_stage2_r	<= 'b0;		
		end
		else begin
			c0_stage2_r <= c0_stage2;
			c1_stage2_r <= c1_stage2;
			s0_stage2_r <= s0_stage2;
			s1_stage2_r	<= s1_stage2;
		end

	end
	wire[63:0]	c0_stage3;
	wire[63:0]	s0_stage3;
//stage3
pp_compressor4_2 pp_compressor4_2_s3(
	.i1	(c0_stage2_r),
	.i2	(s0_stage2_r),
	.i3	(c1_stage2_r),
	.i4	(s1_stage2_r),
	.C	(c0_stage3),
	.S	(s0_stage3)
);
CLA_64bits CLA_64bits_s4(
	.in1(c0_stage3),
	.in2(s0_stage3),
	.cin(1'b0),
	.res(res)
);

// always@(posedge clk)
	// res <=pp0+pp1+pp2+pp3+pp4+pp5+pp6+pp7+pp8+pp9+pp10+pp11+pp12+pp13+pp14+pp15;
//assign	res =pp0+pp1+pp2+pp3+pp4+pp5+pp6+pp7+pp8+pp9+pp10+pp11+pp12+pp13+pp14+pp15;
endmodule