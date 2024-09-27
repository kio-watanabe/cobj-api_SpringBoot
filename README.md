# デモの概要
このデモは、ローン計算を行うAPIを生成します。  
ローン計算を行うのは、COBOLプログラムである[LOANSUB.cbl](./COBOL_source/LOANSUB.cbl)です。  

実際にAPIを呼び出した際に実行されるのは、[LOANSUB.java](./COBOL_source/LOANSUB.java)です。
LOANSUB.javaは、LOANSUB.cblを[opensource COBOL 4J](https://github.com/opensourcecobol/opensourcecobol4j)でJavaに変換したものです。  

APIを呼び出すと、LOANSUBController.javaからLOANSUB.javaのexecuteメソッドが実行されることでローン計算が行われます。  
APIを呼び出す際は、下記の値をパラメータとして渡します。  
* LK_LOAN: 借入額
* LK_INTEREST_RATE: 金利
* LK_PERIODS: 返済期間  

APIを呼び出すとexecuteメソッドが実行されて、下記の値が返されます。  
* LK_PAYMENT: 月々の返済額

# サンプルの起動
1. yum等でmavenとOpenJDK17をインストールする。
1. startup.shを実行する。
    * mvnからSpring-bootのビルドと起動を行っている。
        ```
        ./mvnw spring-boot:run -f pom.xml
        ``` 
1. APIを呼び出す。
    * GETの場合、ブラウザ等でURLにアクセスする。
        * http://localhost:8080/LOANSUB?LK_LOAN=30000000&LK_INTERASTE_RATE=1.5&LK_PERIODS=360
    * この場合、借入額3000万円、金利1.5%、返済期間360ヶ月の場合の月々の返済額を計算し、下記のようなJSONが返される。
        ```json
        {
            "statuscode": 200,
            "LK_LOAN": 30000000,
            "LK_INTEREST_RATE": 1.5,
            "LK_PERIODS": 360,
            "LK_PAYMENT": 103536
        }
        ```
     * statuscodeが200の時は正常終了を意味する。異常終了の場合は500が返される。


