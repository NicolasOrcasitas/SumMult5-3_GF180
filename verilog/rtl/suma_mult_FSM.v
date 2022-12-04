`timescale 1ns / 1ps

//Nicolas Orcasitas Garcia - 2190418

module suma_mult_FSM(
    input clk,
	input start,
	input [15:0] n,
	input [31:0] T,
	input [31:0] C,
	input [31:0] Q,
	input [31:0] X,
	input [15:0] cont,
	output reg Rt,
	output reg Mt,
	output reg Rc,
	output reg Mc,
	output reg Rq,
	output reg Mq,
	output reg Rx,
	output reg Mx,
	output reg Rcont,
	output reg b
	);

	parameter Mantener = 3'b000;
	parameter Preparacion = 3'b001;
	parameter Suma_tres = 3'b010;
	parameter Suma_cinco = 3'b011;
	parameter Suma_quince = 3'b100;
	parameter Reset_cont = 3'b101;
	parameter Suma_final = 3'b110;

	reg [2:0] presente = Mantener;
	reg [2:0] futuro;


	//Registro estado
	always @(posedge clk)
		presente <= futuro;


	//Logica del estado siguiente
	always @(presente, start, n, T, C, Q, X, cont)
		case (presente)
			Mantener:
				if(start)
					futuro <= Preparacion;
				else 
					futuro <= Mantener;
				
				
			Preparacion:
				if(n <= 3)
					futuro <= Mantener;
				else 
					futuro <= Suma_tres;
					
			Suma_tres:
				if(3*(cont+1) < n)
					futuro <= Suma_tres;
				else if(n <= 5)
					futuro <= Suma_final;
				else
					futuro <= Reset_cont;
					
			Suma_cinco:
				if( 5*(cont+1) < n)
					futuro <= Suma_cinco;
				else if(n <= 15)
					futuro <= Suma_final;
				else 
					futuro <= Reset_cont;
					
					
			Suma_quince:
				if( 15*(cont+1) < n)
					futuro <= Suma_quince;
				else 
					futuro <= Suma_final;
					
			Reset_cont:
			    if(C == 0)
			        futuro <= Suma_cinco;
			    else 
			        futuro <= Suma_quince;
					
			Suma_final:
					futuro <= Mantener;
			
			default:
				futuro <= Mantener;
				
		endcase
	
	//Logica de salida
	always @(presente)
		case (presente)
		
			Mantener: begin
				Rt <= 0;
				Mt <= 0;
				Rc <= 0;
				Mc <= 0;
				Rq <= 0;
				Mq <= 0;
				Rx <= 0;
				Mx <= 0;
				b <= 0;
				Rcont <= 0;
			end
				
			Preparacion: begin
				Rt <= 1;
				Mt <= 1;
				Rc <= 1;
				Mc <= 1;
				Rq <= 1;
				Mq <= 1;
				Rx <= 1;
				Mx <= 1;
				b <= 1;
				Rcont <= 0;
			end
			
			Suma_tres: begin
				Rt <= 0;
				Mt <= 1;
				Rc <= 0;
				Mc <= 0;
				Rq <= 0;
				Mq <= 0;
				Rx <= 1;
				Mx <= 1;
				b <= 1;
				Rcont <= 1;
			end
			
			Suma_cinco: begin
				Rt <= 0;
				Mt <= 0;
				Rc <= 0;
				Mc <= 1;
				Rq <= 0;
				Mq <= 0;
				Rx <= 1;
				Mx <= 1;
				b <= 1;
				Rcont <= 1;
			end
			
			Suma_quince: begin
				Rt <= 0;
				Mt <= 0;
				Rc <= 0;
				Mc <= 0;
				Rq <= 0;
				Mq <= 1;
				Rx <= 1;
				Mx <= 1;
				b <= 1;
				Rcont <= 1;
			end
			
			Reset_cont: begin
			    Rcont <= 0;
			    Rt <= 0;
                Mt <= 0;
                Rc <= 0;
                Mc <= 0;
                Rq <= 0;
                Mq <= 0;
                Rx <= 0;
                Mx <= 0;
                b <= 1;
			end
			
			Suma_final: begin
				Rt <= 0;
				Mt <= 0;
				Rc <= 0;
				Mc <= 0;
				Rq <= 0;
				Mq <= 0;
				Rx <= 0;
				Mx <= 1;
				b <= 1;
				Rcont <= 0;
			end
		endcase
endmodule
