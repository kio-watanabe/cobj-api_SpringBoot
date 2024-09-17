      ****************************************************************
      *                                                              *
      *         ���[���ԍϊz�v�Z�i�����ϓ��ԍρj                        *
      *                                                              *
      ****************************************************************
       IDENTIFICATION          DIVISION.
      ****************************************************************
       PROGRAM-ID.             LOANSUB.
       AUTHOR.                 TOKYO-SYSTEM-HOUSE.
       DATE-WRITTEN.           2016/01/14.
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       SOURCE-COMPUTER.        OPEN-COBOL.
       OBJECT-COMPUTER.        OPEN-COBOL.
      ****************************************************************
       DATA                    DIVISION.
      ****************************************************************
       WORKING-STORAGE         SECTION.
       01  WK-INTEREST-RATE    PIC 9(02)V9(03).
       01  WK-INTEREST-YEAR    PIC 9(02)V9(09).
       01  WK-INTEREST-MONTH   PIC 9(02)V9(09).
       01  WK-PERIODS          PIC 999.
       01  WK-PAYMENT          PIC 9(09).
       01  WK-LOAN             PIC 9(09)V9(09).
       01  WK-LOAN-LEFT        PIC 9(09)V9(09).
       01  WK-PRINCIPAL        PIC 9(09).
       01  WK-INTEREST         PIC 9(09).
       01  WK-PERIODS-CNT      PIC 999.
       01  WK-DATE.
           05  WK-YEAR         PIC 9999.
           05  WK-MONTH        PIC 99.
           05  WK-DAY          PIC 99.
       01  WK-KAKUNIN          PIC X.
       01  DSP-PAYMENT         PIC ZZZ,ZZZ,ZZ9.
       01  DSP-PRINCIPAL       PIC ZZZ,ZZZ,ZZ9.
       01  DSP-INTEREST        PIC ZZZ,ZZZ,ZZ9.
       01  DSP-LOAN-LEFT       PIC ZZZ,ZZZ,ZZ9.
       01  DSP-PERIODS-CNT     PIC ZZ9.  
       01  DSP-YEAR            PIC 9999.
       01  DSP-MONTH           PIC 99.          
      *COPY "NUM-IO".
      * 
ADD    LINKAGE                 SECTION.
ADD    01  LK-LOAN             PIC 9(09).
ADD    01  LK-INTEREST-RATE    PIC 9(02)V9(03).
ADD    01  LK-PERIODS          PIC 999.
ADD    01  LK-PAYMENT          PIC 9(09).
      ****************************************************************
       PROCEDURE               DIVISION
ADD                            USING  LK-LOAN,
ADD                                   LK-INTEREST-RATE,
ADD                                   LK-PERIODS,
ADD                                   LK-PAYMENT.
      ****************************************************************
       HAJIME.
       MAIN-000.
      *     DISPLAY "***  ���[���ԍϊz�v�Z  ***" .
      *     DISPLAY "�ؓ����z: " NO ADVANCING.
      *     COPY "NUM-ACP" REPLACING =='#1'==  BY ==WK-LOAN==..
      *     DISPLAY "�N�� (%): " NO ADVANCING.        
      *     COPY "NUM-ACP" REPLACING =='#1'==  BY ==WK-INTEREST-RATE==..
      *     DISPLAY "���[������(��): " NO ADVANCING.
      *     COPY "NUM-ACP" REPLACING =='#1'==  BY ==WK-PERIODS==..
ADD        MOVE  LK-LOAN           TO   WK-LOAN.
ADD        MOVE  LK-INTEREST-RATE  TO   WK-INTEREST-RATE.
ADD        MOVE  LK-PERIODS        TO   WK-PERIODS.
       MAIN-100.
           COMPUTE WK-INTEREST-YEAR  = WK-INTEREST-RATE / 100.
           COMPUTE WK-INTEREST-MONTH = WK-INTEREST-YEAR / 12.
           COMPUTE WK-PAYMENT ROUNDED
                 = (WK-LOAN * WK-INTEREST-MONTH *
                    ((1 + WK-INTEREST-MONTH) ** (WK-PERIODS)))
                 / ((1 + WK-INTEREST-MONTH) ** (WK-PERIODS) - 1).            
ADD        MOVE  WK-PAYMENT        TO   LK-PAYMENT.
ADD        GO TO OWARI.
       MAIN-200.
           DISPLAY "返済額(月) = " NO ADVANCING.
           MOVE WK-PAYMENT TO DSP-PAYMENT.
           DISPLAY DSP-PAYMENT.
           DISPLAY "印刷しますか?(Y/N)".
           ACCEPT WK-KAKUNIN.
           IF WK-KAKUNIN NOT = "Y"
               GO TO OWARI.
       MAIN-300.
           MOVE  WK-LOAN TO WK-LOAN-LEFT.
           MOVE  1       TO WK-PERIODS-CNT.
           ACCEPT WK-DATE FROM DATE YYYYMMDD.
      *            "ZZ9 9999/99  ZZZ,ZZZ,ZZ9 ZZZ,ZZZ,ZZ9 ZZZ,ZZZ,ZZ9 ZZZ,ZZZ,ZZ9"     
           DISPLAY "NO  年月    支払        原本        利息           
      -            "    残元金".
           DISPLAY "--- ------- ----------- ----------- ----------- ----
      -            "-------".
       MAIN-210.
           COMPUTE WK-INTEREST  ROUNDED
                   = WK-LOAN-LEFT * WK-INTEREST-MONTH.
           COMPUTE WK-PRINCIPAL = WK-PAYMENT - WK-INTEREST.
           COMPUTE WK-LOAN-LEFT = WK-LOAN-LEFT - WK-PRINCIPAL.
           IF WK-PERIODS-CNT = WK-PERIODS
              ADD  WK-LOAN-LEFT  TO WK-PRINCIPAL
                                    WK-PAYMENT
              MOVE ZERO          TO WK-LOAN-LEFT.
           MOVE    WK-PERIODS-CNT TO DSP-PERIODS-CNT.
           MOVE    WK-PAYMENT    TO DSP-PAYMENT.
           MOVE    WK-INTEREST   TO DSP-INTEREST.
           MOVE    WK-PRINCIPAL  TO DSP-PRINCIPAL.
           MOVE    WK-LOAN-LEFT  TO DSP-LOAN-LEFT.
           DISPLAY WK-PERIODS-CNT " " WK-YEAR "/" WK-MONTH " "
                   DSP-PAYMENT " "
                   DSP-PRINCIPAL " " DSP-INTEREST " "
                   DSP-LOAN-LEFT.
           COMPUTE WK-PERIODS-CNT = WK-PERIODS-CNT + 1.
           IF WK-MONTH = 12
              MOVE 1 TO WK-MONTH
              ADD  1 TO WK-YEAR
           ELSE
              ADD  1 TO WK-MONTH.     
           IF WK-PERIODS-CNT > WK-PERIODS
              GO TO OWARI.
           GO TO MAIN-210.
       OWARI.
      *     STOP RUN.
ADD        GOBACK.
      *--------------------<< END OF PROGRAM >>-----------------------*
