`timescale 1ns / 1ps

//Nicolas Orcasitas Garcia - 2190418

module suma_mult_TOP(
    input clk,
    input start,
    //input boton,
    input [15:0] n,
    output [31:0] X,
    output b
    //output [15:0] led
    //output [6:0] seg7
    );
    
    wire Rt, Mt, Rc, Mc, Rq, Mq, Rx, Mx, Rcont; // b
    wire [31:0] T, C, Q; // X 
    wire [15:0] cont;
    
    suma_mult_DP Datapath(
        .clk(clk),
        .n(n),
        .Rt(Rt),
        .Mt(Mt),
        .Rc(Rc),
        .Mc(Mc),
        .Rq(Rq),
        .Mq(Mq),
        .Rx(Rx),
        .Mx(Mx),
        .Rcont(Rcont),
        .T(T),
        .C(C),
        .Q(Q),
        .X(X),
        .cont(cont)
    );
    
    suma_mult_FSM Control_Unit(
        .clk(clk),
        .n(n),
        .start(start),
        .Rt(Rt),
        .Mt(Mt),
        .Rc(Rc),
        .Mc(Mc),
        .Rq(Rq),
        .Mq(Mq),
        .Rx(Rx),
        .Mx(Mx),
        .Rcont(Rcont),
        .T(T),
        .C(C),
        .Q(Q),
        .X(X),
        .b(b),
        .cont(cont)
    );
    
//    always @(posedge boton)
//        sw <= ~sw;

    //assign seg7[0] = ~b;
    //assign seg7[1] = ~b;
    //assign seg7[2] = ~b;
    //assign seg7[3] = ~b;
    //assign seg7[4] = ~b;
    //assign seg7[5] = ~b;
    //assign seg7[6] = ~b;    
    //assign led = (boton)? X[31:16]: X[15:0];
                
//    seg <= 7'b0000001; // Cero
//    seg <= 7'b1001111; // Uno
//    seg <= 7'b0010010; // Dos
//    seg <= 7'b1111110; // Linea
    
endmodule
