module lab4_0 #(
    parameter SIZE = 8
) (
    input  logic [SIZE-1:0] a,
    input  logic [SIZE-1:0] b,
    output logic [SIZE-1:0] s,
    output logic            overflow
);

    logic sign_a, sign_b, sign_s_int;
    logic [SIZE-2:0] mag_a, mag_b, mag_s_int;
    logic carry;
    
    logic [SIZE-1:0] mag_sum_ext;

    assign sign_a = a[SIZE-1];
    assign sign_b = b[SIZE-1];
    assign mag_a = a[SIZE-2:0];
    assign mag_b = b[SIZE-2:0];

    always_comb begin
        overflow = 1'b0;
        mag_sum_ext = {(SIZE){1'b0}};
        mag_s_int = {(SIZE-1){1'b0}};
        sign_s_int = 1'b0;
        carry = 1'b0;

        if (sign_a == sign_b) begin
            sign_s_int = sign_a;
            
            mag_sum_ext = {1'b0, mag_a} + {1'b0, mag_b};
            carry = mag_sum_ext[SIZE-1];
            overflow = carry;
            
            mag_s_int = mag_sum_ext[SIZE-2:0];

        end else begin
            overflow = 1'b0;
            
            if (mag_a >= mag_b) begin
                sign_s_int = sign_a;
                mag_s_int = mag_a - mag_b;
            end else begin
                sign_s_int = sign_b;
                mag_s_int = mag_b - mag_a;
            end
        end

        if (mag_s_int == {(SIZE-1){1'b0}}) begin
            sign_s_int = 1'b0;
        end

        s = {sign_s_int, mag_s_int};
    end
endmodule
