# サンプルの起動

* yum等でmavenとOpenJDK17を導入
* startup.shを実行
    * mvnからSpring-bootのビルドと起動を行っている
```
./mvnw spring-boot:run -f pom.xml
```
* ブラウザ等でURLにアクセスする
 * http://localhost:8080/LOANSUB?LK_LOAN=30000000&LK_INTERASTE_RATE=1.5&LK_PERIODS=360

# Spring bootフレームワーク側のファイル

* src/main/java/com/example/restservice/LOAN.java

RESTAPIから返すデータ型を規定するクラス
IOAREA.xmlの簡易版のようなもの

* src/main/java/com/example/restservice/LoanCalcController.java

RESTAPIに機能を登録するためのコントローラ
@GetMappingにてAPIのパスを指定し、受け取るパラメータを@RequestParamで設定する
returnでLOAN.javaの定義を返すと自動でJSON化される

* cobol/LOANCALC.cbl

コントローラから呼び出されるCOBOLプログラム

* src/main/java/com/example/restservice/LOANCALC.java

上記COBOLから生成されたJava

