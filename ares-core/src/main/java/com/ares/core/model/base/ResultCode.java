package com.ares.core.model.base;

import lombok.Getter;

/**
 * @description:
 * @author: Young 2020/03/30
 **/
@Getter
public enum ResultCode {

    SUCCESS(200, "成功"),
    FAILED(500, "错误"),
    VALIDATE_FAILED(10001, "参数校验失败"),
    UNKNOWN(10000, "未知错误"),
    NOUSER(90001, "用户不存在"),
    NOLOGIN(90002, "用户没有登录"),
    LOGINTIMEOUT(90003, "session过期"),
    NOAUTH(90004, "用户没有权限"),
    PWDERROR(90005, "密码错误"),
    CODEERROR(90006, "验证码错误"),
    NOMODEL(20000, "模型不存在"),
    NOFLOW(20001, "请先设计流程定义并成功保存，再进行部署"),
    ERRORFLOWDEFINITION(20002, "流程定义不符要求，请至少设计一条主线流程");
    private int code;

    private String msg;

    ResultCode(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

}
