`timescale 1ns / 1ps

//Nicolas Orcasitas Garcia - 2190418

module suma_mult_DP(
    input clk,
	input [15:0] n,
	input Rt,
	input Mt,
	input Rc,
	input Mc,
	input Rq,
	input Mq,
	input Rx,
	input Mx,
	input Rcont,
	output reg [31:0] T,
	output reg [31:0] C,
	output reg [31:0] Q,
	output reg [31:0] X,
	output reg [15:0] cont
    );
    //Reg cont
    wire [15:0] nextcont;
 
    // Reg T
    wire [31:0] nextT;
    
    //Reg C
    wire [31:0] nextC;
    
    //Reg Q
    wire [31:0] nextQ;
    
    //Reg X
    wire [31:0] nextX;
    
    
    //Registro T
    always @(posedge clk)
        T <= nextT;
    
    //Parte combinacional
    assign nextT = (Mt)? (Rt)? 32'b0 : T + 3*cont : T;
    
    
    //Registro C
    always @(posedge clk)
        C <= nextC;
    
    //Parte combinacional
    assign nextC = (Mc)? (Rc)? 32'b0 : C + 5*cont : C;
    
    
    //Registro Q
    always @(posedge clk)
        Q <= nextQ;
    
    //Parte combinacional
    assign nextQ = (Mq)? (Rq)? 32'b0 : Q + 15*cont : Q;
    
    //Registro contador
    always @(posedge clk)
        cont <= nextcont;
        
    assign nextcont = (Rcont)? (cont + 1): 0;
    
    
    //Registro X
    always @(posedge clk)
        X <= nextX;
    
    //Parte combinacional
    assign nextX = (Mx)? (Rx)? 32'b0 : T + C - Q : X;
    
    
endmodule
