# デモの概要
* このデモは、ローン計算を行うAPIを生成します。
* 借入額、金利、返済期間を入力すると、月々の返済額を計算します。

# COBOLプログラムの呼び出し
* ローン計算はLOANSUB.javaのexecuteメソッドを実行することで行います。
* LOANSUB.javaは、COBOLプログラムであるLOANSUB.cblをJavaに変換したものです。
* LOANSUBController.javaからexecuteメソッドが実行されることでローン計算が行われます。

# サンプルの起動

* yum等でmavenとOpenJDK17を導入
* startup.shを実行
    * mvnからSpring-bootのビルドと起動を行っている
        ```
        ./mvnw spring-boot:run -f pom.xml
        ``` 
* ブラウザ等でURLにアクセスする
    * http://localhost:8080/LOANSUB?LK_LOAN=30000000&LK_INTERASTE_RATE=1.5&LK_PERIODS=360
    * この場合、借入額3000万円、金利1.5%、返済期間360ヶ月の場合の月々の返済額を計算し、下記のようなJSONが返されます。
        ```json
        {
            "statuscode": 200,
            "LK_LOAN": 30000000,
            "LK_INTEREST_RATE": 1.5,
            "LK_PERIODS": 360,
            "LK_PAYMENT": 103536
        }
        ```
  * statuscodeが200の場合は正常終了です。異常終了の場合は500が返されます。


