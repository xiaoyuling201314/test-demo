#汇付公钥私钥配置
1. 公钥私钥生产工具类：RSAEncryptGeneration，路径：src/main/java/com/dayuan3/api/common/RSAEncryptGeneration.java
2. 生产之后将公钥和私钥文件复制到resources/mallCert目录下
3.  .pfx私钥 .cer公钥
4. 将私钥配置到系统参数中“汇付聚合支付支付相关”中的“merchant_private_key”，如果是测试环境还需要修改“prodEnv”为false
    - 正式环境配置
    {
        "mallbook": {
            "pay_url": "https://cloudpay.mallbook.cn/api",
            "merchant_no": "MBH25059",
            "prodEnv": true,
            "version": "1.3.0",
            "frontUrl": "https://dev.6tfish.com/frontNotice",
            "notifyUrl": "http://ltlj.chinafst.cn:8081/dykjfw/api/payNotify",
            "merchant_private_key": "MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAPR+G00mQ9tvLZsWj2oEIpT0ez/uPYx7e1YrcUyaRqXsYojsrybRfwSi/BOuwMO9Ntxp/3tGNChtViG49p/9iJ7lcNXaU5IpT70hRC//1Lr6yj9ihWRV3RM+ftFUPLmex1jYk9qRaLpIe4bbsa9MKAYvNSvJO0tA67p8YZYi4Jr9AgMBAAECgYAzYLzD/aKM3lQrHxaMJMpPmwC7cokkmF5WwVJR0qm9/GrIc1RrR+L1SnrGeBayC3UX5H53nU0goblT5NaO0GyA7nUijdRbByRXCSc8uXofH5ow/4cXo13sSFFvztomMpkHzB9psGLV4xzLm+jBN/Pb0YRm5DiSzzmfVQ1MlthxUQJBAP4iTK80QnX+GYbDXshNhquB+gj98OhE7BwWz8dP7qzGEFwa2AmhzWrKJ1M7Ud+b3rzY6c5r47bceGthnrzP9isCQQD2Sa8brU+irOevDpMxTcrFCML5woDXJc2lKZ7zuEeMYLV3p4WLojoCTKXIxYfd6ryAHJpy+c3ak6J0Ggi4bgd3AkAfoWtD/1AqWXcZ4+U/Lw8M97+EMP80Gaf9kwVHfHZrgLd2j0zGXiIwIXsli+OT3lWp0aHANIOCNgyy6NKWE5hDAkBdgLHzTwQJ3Z0EEAN/12nhDid/zQE/LUH6r2eCXfcD639ZkwcXcRqW3uSd6ahgbwrrlHBqsD4f+qbVb0DaTCOXAkALqPeOMa7EkZS3YBPFLQrrXVbZUpEkx82OjW9E0yX2bLlv/9HsKaEOBvzYVile6RZb/t84b/CjtNfzTLXqLU2v",
            "mall_book_public_key": "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCq6OLZKgUHH5wOk9xSBgN7yC17r3PQwMlY9/IorqrOlaIqrU0eAVZ5+dWrJD/3bdu7Ctq8n8trTm/IUYs7wtMg5SKwyX4/N+KQc2N7LL4yCq4vNl41q9sYgrtA0QnZoucIZcq1mwyu7RTDC8Wp7LGddnlkJsmL8masgMxA6cc9NwIDAQAB"
        }
    }
    - 测试环境配置
    {
        "mallbook": {
            "pay_url": "https://uat-cloudpay.mallbook.cn/api",
            "merchant_no": "HF20250623",
            "prodEnv": false,
            "version": "1.3.0",
            "frontUrl": "https://dev.6tfish.com/frontNotice",
            "notifyUrl": "http://fc6b625a.natappfree.cc/dykjfw/api/pay/payNotify",
            "merchant_private_key": "MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAIh7G8AvOi3AB1fQ2dSzOuIURGGZVK3F1u8NsJnLmDGSFB93ZEirZyvljHr2IUure6f9OuadheJ5x1j+XWUyMAjKAZWkEpY7ow/Eg+TmffIj5I+yokFxPGBsmeWs+EYC7vq0hx6XtlcDAUGR1b8oKnPuuZ4U/K1FXuBzYGg724xXAgMBAAECgYB4DmNg8app6EwNUajs1CTuDwoAGNNGcYwaiZ5aC6B7qpaM/4d17WE6WhjzaWPsnpKOOdIAX30QtjNH86nQhQ9+vBrnxU4KQvUDQKIVat+3PWL3vTUM/sU34yBUy70utMCfWh3UBbbZUaUSTmcHF6xYB/yDwJKtMOA0jFaO5ZCiAQJBAOUC8CfASmy4VuLoFqRSXh48xlg64KJfINNEcpdep1e4iGiqLt0NbXI9fj3a7gtE3ywS+O0C2iaPTnBevOddVYECQQCYkJvyQWfyw7lYPMtrzx2hjgIjfOxJrBjZTc/kc6RTjvSyBuGy66HP707BinsmGacbfvBEshnw3L5jelUVmT3XAkEAzbtc+akCczcLPx7WsFoamTlpyftisBubho/YDeoHlYN+b+Bq50TXzKg3j+Pss4z0nEiS/YDxb3CQO9ywAX1UgQJBAIfpzAO1YPVUh/mjr1UL3kneSOl0kMvRFRIB0AKlQu9tm3A90TOj1zN27aJdy/fVQpmsLEAGqjV5ceMNSF9FdWECQQCtGRRvM/V45S1bv2H5V0xbrYlsdMO/YnWvUA/jED95hydWgkdZGl/D4oG0NKWbqswlMf8SvxWhgdcu0nCBsZHk",
            "mall_book_public_key": "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQD0L2DaHOO8ekhktB6RoHxIcki/0v7OUeOn9tX9VBE+jv6PRjqlZRWL3Qezxz5ADtHEyLv+RFFaceXSep6rWyoQ6DRlvLv5CySUAxAM42LLVe4DI3l/0ccEAIuU5NCpwAAj1zkm2X01DwUCZwymLjlqbDlBvQhpq+1fddtTtA/QLQIDAQAB"
        }
    }
    - SDK配置示例：
    #  mallbook 调起接口参数配置
    mallbook:
      # pay_url:MallBook接口地址    UAT环境： https://uat-cloudpay.mallbook.cn/api   生产环境：https://cloudpay.mallbook.cn/api
      pay_url: https://uat-cloudpay.mallbook.cn/api
      # merchant_no 业务系统商户平台编号，需替换为MallBook工作人员提供的商户编号
      merchant_no: HF20250623
      # version 接口版本号
      version: 1.3.0
      # merchant_private_key 商户平台私钥，需要替换成商户平台自己生成的私钥
      merchant_private_key: MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAIpokXS70GBpX6bLA6I+0jEZZyIdDT8rmE4KsVP/gV89Z6Aue2iHZliB0sFfm+O2+O3dLR+/hdenYnbFXOZcp4XFoNzZUBu2iPnK5d4ErlVDmNr0VJsCFuwD9yBdjJElkWtKj8E98ArZ2V44OSiwxyr7u821FzsR/TtzAw3xsDGVAgMBAAECgYEAgDSwV7MJJ+UzpupyaT1LshNXxu+mL5eQMuoQrEAGdFQKwwOLaJ3THbTTpi+L1PjNyHeRrtDXh5USzfWvQesdeJ1YZ98RtoY4Nz/edTKrGX3qTkDojCc5vPqZwiMp7F1hp6zuu8iO+qJTP4rCNiO90tmjjGO4Z52xRWy38O2/J1kCQQDCezz8qQiGyyaeVaayB2CMVkKQuRr2UGYcQEUc9tUYzbGCMt507eY1okbNzUWKzaoInJdyhBEQ1IrEZOG03W3vAkEAtjCkhzePo+awuG+BEwHbnsKMVOdGqVD8FQtfEsD4PzVyUXC+wfrERsY+bonOw2n6b8awBrCAKrOYTsAN1YFcuwJBAIeUUpfxXzhZN7r6CxPhgLVVDWLHKLy+n/Dh/UyL51M7UpxpyhvKHcsWLjYa/HgfmIIYaJw05ZDOG09+5LqqA5ECQCNRwMOZ6NXMZhwLOcmWhZ38dzoKb+9pDMWDo9W95SJT2Sqioch3Nc/GpNnHC3dktzEuInfZha9Bi9hQcR4f6vsCQAZd6vtg3YCd4paPveAF3VuOKaJunCqj3cA3maMcLmTpgZ9eYDYPEywecwuigUY979/5n4Zt3KDdGX+nmGHD5b0=
      # mall_book_public_key mallbook测试环境公钥 不需要替换
      mall_book_public_key: MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQD0L2DaHOO8ekhktB6RoHxIcki/0v7OUeOn9tX9VBE+jv6PRjqlZRWL3Qezxz5ADtHEyLv+RFFaceXSep6rWyoQ6DRlvLv5CySUAxAM42LLVe4DI3l/0ccEAIuU5NCpwAAj1zkm2X01DwUCZwymLjlqbDlBvQhpq+1fddtTtA/QLQIDAQAB
      # mall_book_public_key mallbook生产环境公钥  不需要替换
    #  mall_book_public_key: MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCq6OLZKgUHH5wOk9xSBgN7yC17r3PQwMlY9/IorqrOlaIqrU0eAVZ5+dWrJD/3bdu7Ctq8n8trTm/IUYs7wtMg5SKwyX4/N+KQc2N7LL4yCq4vNl41q9sYgrtA0QnZoucIZcq1mwyu7RTDC8Wp7LGddnlkJsmL8masgMxA6cc9NwIDAQAB

    - 参数说明：
    pay_url：MallBook接口地址，UAT环境： https://uat-cloudpay.mallbook.cn/api   生产环境：https://cloudpay.mallbook.cn/api；
    merchant_no：业务系统商户平台编号，需替换为MallBook工作人员提供的商户编号
    prodEnv：是否生产环境：开发环境：false，生产环境设为false
    version ：接口版本号，
    frontUrl：前台回调地址，微信公众号支付完成后跳转至Mallbook点金计划页面，可从点金计划页面跳转至商户平台的前台回调地址
    notifyUrl：后台回调地址，接收交易结果状态
    merchant_private_key：商户平台私钥，需要替换成商户平台自己生成的私钥
    mall_book_public_key：mallbook公钥
5. 将公钥配置到汇付商户管理控制台：平台商户需要登入Mallbook平台商户管理控台，系统管理>>商户开发信息管理,进行公钥配置；
6. 商户管理控台地址：https://cloud.mallbook.cn/merchant/#/login
   登录账号：MBH25059
   密码：Mb@250624
7. 如果本地调用汇付接口正常，部署到服务器上提示验签失败，请先核对系统参数配置是否正确，然后配置Tomcat编码，
在tomcat/bin目录新增setenv.bat文件，然后设置编码，如下所示：
:: 在 Tomcat 的 bin 目录创建 setenv.bat
SET TITLE=dykjfw_8081
set "JAVA_OPTS=%JAVA_OPTS% -Dfile.encoding=UTF-8"