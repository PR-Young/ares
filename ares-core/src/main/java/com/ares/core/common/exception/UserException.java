package com.ares.core.common.exception;

import lombok.Data;

/**
 * @description:
 * @author: Young 2020/05/09
 **/
@Data
public class UserException extends RuntimeException {

    private static final long serialVersionUID = 6109496485495487838L;
    private Integer code;
    private String message;

    public UserException() {
        super();
    }

    public UserException(String message) {
        super(message);
        this.message = message;
    }

    public UserException(Integer code, String message) {
        super(message);
        this.code = code;
        this.message = message;
    }

    public UserException(String message, Throwable e) {
        super(message, e);
    }
}
