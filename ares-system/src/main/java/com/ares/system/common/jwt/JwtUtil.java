package com.ares.system.common.jwt;


import com.ares.config.base.BaseConfig;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.auth0.jwt.interfaces.JWTVerifier;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.Date;

/**
 * @description:
 * @author: Young 2020/05/09
 **/
@Component
public class JwtUtil {

    @Resource
    BaseConfig baseConfig;
    private static BaseConfig config;

    @PostConstruct
    public void init() {
        config = baseConfig;
    }

    /**
     * 校验token是否正确
     *
     * @param token    密钥
     * @param password 用户的密码
     * @return 是否正确
     */
    public static boolean verify(String token, String username, String password) {
        try {
            Algorithm algorithm = Algorithm.HMAC256(password);
            JWTVerifier verifier = JWT.require(algorithm)
                    .withClaim("username", username)
                    .build();
            DecodedJWT jwt = verifier.verify(token);
            return true;
        } catch (Exception exception) {
            return false;
        }
    }

    /**
     * 获得token中的信息无需password解密也能获得
     *
     * @return token中包含的用户名
     */
    public static String getUsername(String token) {
        try {
            DecodedJWT jwt = JWT.decode(token);
            return jwt.getClaim("username").asString();
        } catch (JWTDecodeException e) {
            return null;
        }
    }

    /**
     * 生成签名,5min后过期
     *
     * @param username 用户名
     * @param password 用户的密码
     * @return 加密的token
     */
    public static String sign(String username, String password) {
        Date date = new Date(System.currentTimeMillis() + (config.getTimeout() * 1000));
        Algorithm algorithm = Algorithm.HMAC256(password);
        // 附带username信息
        return JWT.create()
                .withClaim("username", username)
                .withExpiresAt(date)
                .sign(algorithm);
    }

    public static boolean isExpired(String token) {
        DecodedJWT decodedJWT = JWT.decode(token);
        if (null == decodedJWT) {
            return true;
        }
        Date date = decodedJWT.getExpiresAt();
        return date.before(new Date());
    }

}
