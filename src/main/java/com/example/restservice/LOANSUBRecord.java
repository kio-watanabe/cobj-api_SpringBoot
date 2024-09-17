package com.example.restservice;

public record LOANSUBRecord(int statuscode, int LK_LOAN, double LK_INTEREST_RATE, int LK_PERIODS, int LK_PAYMENT) {
    public LOANSUBRecord(){
        this(0, 0, 0.0, 0, 0);
    }
}
