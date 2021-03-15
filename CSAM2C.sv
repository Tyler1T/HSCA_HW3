module CSAM2C(Z, X, Y);

        input logic [3:0] Y;
        input logic [7:0] X;
        output logic [11:0] Z;


        logic [7:0] P0;
        logic [7:0] carry1;
        logic [7:0] sum1;
        logic [7:0] P1;
        logic [7:0] carry2;
        logic [7:0] sum2;
        logic [7:0] P2;
        logic [7:0] carry3;
        logic [7:0] sum3;
        logic [7:0] P3;
        logic [7:0] carry4;
        logic [7:0] sum4;
        logic [10:0] carry5;

        wire cout;


        // generate the partial products.
        partialNProduct pp1(P0[7], X[7], Y[0]);
        partialProduct pp2(P0[6], X[6], Y[0]);
        partialProduct pp3(P0[5], X[5], Y[0]);
        partialProduct pp4(P0[4], X[4], Y[0]);
        partialProduct pp5(P0[3], X[3], Y[0]);
        partialProduct pp6(P0[2], X[2], Y[0]);
        partialProduct pp7(P0[1], X[1], Y[0]);
        partialProduct pp8(P0[0], X[0], Y[0]);
        partialNProduct pp9(sum1[7], X[7], Y[1]);
        partialProduct pp10(P1[6], X[6], Y[1]);
        partialProduct pp11(P1[5], X[5], Y[1]);
        partialProduct pp12(P1[4], X[4], Y[1]);
        partialProduct pp13(P1[3], X[3], Y[1]);
        partialProduct pp14(P1[2], X[2], Y[1]);
        partialProduct pp15(P1[1], X[1], Y[1]);
        partialProduct pp16(P1[0], X[0], Y[1]);
        partialNProduct pp17(sum2[7], X[7], Y[2]);
        partialProduct pp18(P2[6], X[6], Y[2]);
        partialProduct pp19(P2[5], X[5], Y[2]);
        partialProduct pp20(P2[4], X[4], Y[2]);
        partialProduct pp21(P2[3], X[3], Y[2]);
        partialProduct pp22(P2[2], X[2], Y[2]);
        partialProduct pp23(P2[1], X[1], Y[2]);
        partialProduct pp24(P2[0], X[0], Y[2]);
        partialProduct pp25(sum3[7], X[7], Y[3]);
        partialNProduct pp26(P3[6], X[6], Y[3]);
        partialNProduct pp27(P3[5], X[5], Y[3]);
        partialNProduct pp28(P3[4], X[4], Y[3]);
        partialNProduct pp29(P3[3], X[3], Y[3]);
        partialNProduct pp30(P3[2], X[2], Y[3]);
        partialNProduct pp31(P3[1], X[1], Y[3]);
        partialNProduct pp32(P3[0], X[0], Y[3]);

        // Array Reduction
        halfAdder  HA1(carry1[6],sum1[6],P1[6],P0[7]);
        halfAdder  HA2(carry1[5],sum1[5],P1[5],P0[6]);
        halfAdder  HA3(carry1[4],sum1[4],P1[4],P0[5]);
        halfAdder  HA4(carry1[3],sum1[3],P1[3],P0[4]);
        halfAdder  HA5(carry1[2],sum1[2],P1[2],P0[3]);
        halfAdder  HA6(carry1[1],sum1[1],P1[1],P0[2]);
        halfAdder  HA7(carry1[0],sum1[0],P1[0],P0[1]);
        fullAdder  FA1(carry2[6],sum2[6],P2[6],sum1[7],carry1[6]);
        fullAdder  FA2(carry2[5],sum2[5],P2[5],sum1[6],carry1[5]);
        fullAdder  FA3(carry2[4],sum2[4],P2[4],sum1[5],carry1[4]);
        fullAdder  FA4(carry2[3],sum2[3],P2[3],sum1[4],carry1[3]);
        fullAdder  FA5(carry2[2],sum2[2],P2[2],sum1[3],carry1[2]);
        fullAdder  FA6(carry2[1],sum2[1],P2[1],sum1[2],carry1[1]);
        fullAdder  FA7(carry2[0],sum2[0],P2[0],sum1[1],carry1[0]);
        fullAdder  FA8(carry3[6],sum3[6],P3[6],sum2[7],carry2[6]);
        fullAdder  FA9(carry3[5],sum3[5],P3[5],sum2[6],carry2[5]);
        fullAdder  FA10(carry3[4],sum3[4],P3[4],sum2[5],carry2[4]);
        fullAdder  FA11(carry3[3],sum3[3],P3[3],sum2[4],carry2[3]);
        fullAdder  FA12(carry3[2],sum3[2],P3[2],sum2[3],carry2[2]);
        fullAdder  FA13(carry3[1],sum3[1],P3[1],sum2[2],carry2[1]);
        fullAdder  FA14(carry3[0],sum3[0],P3[0],sum2[1],carry2[0]);

        // Generate lower product bits YBITS
        buf b1(Z[0], P0[0]);
        assign Z[1] = sum1[0];
        assign Z[2] = sum2[0];
        assign Z[3] = sum3[0];

        // Final Carry Propagate Addition
        halfAdder CPA1(carry4[0],Z[4],carry3[0],sum3[1]);
        fullAdder CPA2(carry4[1],Z[5],carry3[1],carry4[0],sum3[2]);
        fullAdder CPA3(carry4[2],Z[6],carry3[2],carry4[1],sum3[3]);
        fullAdder CPA4(carry4[3],Z[7],carry3[3],carry4[2],sum3[4]);
        fullAdder CPA5(carry4[4],Z[8],carry3[4],carry4[3],sum3[5]);
        fullAdder CPA6(carry4[5],Z[9],carry3[5],carry4[4],sum3[6]);
        fullAdder CPA7(cout,Z[10],carry3[6],carry4[5],sum3[7]);

        assign Z[11] = ~cout;

endmodule
