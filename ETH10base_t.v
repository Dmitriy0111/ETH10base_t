module ETH10base_t
(
    input   clk,
    output  Txp,
    output  Txn

);

nlp nlp_0
    (
        .clk(clk),
        .Txp(Txp),
        .Txn(Txn)
    );

endmodule
