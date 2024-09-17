package com.example.restservice;
import java.util.concurrent.atomic.AtomicLong;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import jp.osscons.opensourcecobol.libcobj.ui.*;

@RestController
public class LOANSUBController {
    @GetMapping("/LOANSUB")
    public LOANSUBRecord LOANSUBController(
        @RequestParam(value = "LK-LOAN", defaultValue = "0") int LK-LOAN,
        @RequestParam(value = "LK-INTEREST-RATE", defaultValue = "0") double LK-INTEREST-RATE,
        @RequestParam(value = "LK-PERIODS", defaultValue = "0") int LK-PERIODS,
        @RequestParam(value = "LK-PAYMENT", defaultValue = "0") int LK-PAYMENT
    ) {
        int statuscode = 200;
        LOANSUB LOANSUBCobol = new LOANSUB();
        CobolResultSet result = LOANSUBCobol.execute(LK-LOAN, LK-INTEREST-RATE, LK-PERIODS, LK-PAYMENT);
        try {
            LK-LOAN = result.getInt(1);
            LK-INTEREST-RATE = result.getDouble(2);
            LK-PERIODS = result.getInt(3);
            LK-PAYMENT = result.getInt(4);
        } catch (Exception e) {
            statuscode = 500;
        }
        return new LOANSUBRecord(statuscode, LK-LOAN, LK-INTEREST-RATE, LK-PERIODS, LK-PAYMENT);
    }
}
