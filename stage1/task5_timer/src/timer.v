/**
 * @brief timer module: hh:mm:ss
 * @in
    * clk: clock signal
    * rst: reset signal
 * @out
    * out: 6 decimal system digits array
 * 
 */
module timer(clk, rst, start, out);
    input clk;
    input rst;
    input start;
    output reg[5:0][3:0] out;

    reg[23:0] counter;

    initial begin
        out[0] = 4'b0000; // s
        out[1] = 4'b0000; // s
        out[2] = 4'b0000; // m
        out[3] = 4'b0000; // m
        out[4] = 4'b0000; // h
        out[5] = 4'b0000; // h
    end

    always @(posedge clk) begin
        
    end

    always@(posedge clk or negedge rst) begin
        if (!rst) begin
            counter <= 0;
            out[0] <= 4'b0000;
            out[1] <= 4'b0000;
            out[2] <= 4'b0000;
            out[3] <= 4'b0000;
            out[4] <= 4'b0000;
            out[5] <= 4'b0000;
        end
        else begin
            if (counter < 50000000) begin // 50000000 个时钟周期 (1 s) 后 out + 1
                counter = counter + 1;
            end
            else begin
                counter <= 0;
                if (out[5] == 4'b1001) begin
                    out[5] <= 4'b0000;
                    if (out[4] == 4'b1001) begin
                        out[4] <= 4'b0000;
                        if (out[3] == 4'b1001) begin
                            out[3] <= 4'b0000;
                            if (out[2] == 4'b1001) begin
                                out[2] <= 4'b0000;
                                if (out[1] == 4'b1001) begin
                                    out[1] <= 4'b0000;
                                    if (out[0] == 4'b1001) begin
                                        out[0] <= 4'b0000;
                                    end
                                    else begin
                                        out[0] <= out[0] + 1;
                                    end
                                end
                                else begin
                                    out[1] <= out[1] + 1;
                                end
                            end
                            else begin
                                out[2] <= out[2] + 1;
                            end
                        end
                        else begin
                            out[3] <= out[3] + 1;
                        end
                    end
                    else begin
                        out[4] <= out[4] + 1;
                    end
                end
                else begin
                    out[5] <= out[5] + 1;
                end
            end
        end
    end
endmodule
