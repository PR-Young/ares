package com.ares.core.utils;


import com.ares.core.common.exception.UserException;
import com.ares.core.common.jwt.JwtUserDetails;
import com.ares.core.persistence.model.exception.ErrorCode;
import com.ares.core.persistence.model.system.SysUser;
import com.ares.core.persistence.service.SysUserService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * @description:
 * @author: Young
 * @date: 2022/1/13
 * @see: com.ares.core.utils.SecurityUtils.java
 **/
public class SecurityUtils {

    /**
     * 获取用户账户
     **/
    public static String getUsername() {
        String username = null;
        Authentication authentication = getAuthentication();
        if (authentication != null) {
            Object principal = authentication.getPrincipal();
            if (principal != null) {
                if (principal instanceof JwtUserDetails) {
                    username = ((UserDetails) principal).getUsername();
                } else if (principal instanceof String) {
                    username = (String) principal;
                }
            }
        }
        return username;
    }

    /**
     * 获取用户
     **/
    public static SysUser getLoginUser() throws UserException {
        String userName = getUsername();
        if (null == userName) {
            throw new UserException(ErrorCode.NOUSER.getCode(), "用户不存在！");
        }
        SysUserService userService = SpringUtils.getBean(SysUserService.class);
        SysUser user = userService.getUserByName(userName);
        return user;
    }

    /**
     * 获取Authentication
     */
    public static Authentication getAuthentication() {
        return SecurityContextHolder.getContext().getAuthentication();
    }

    /**
     * 生成BCryptPasswordEncoder密码
     *
     * @param password 密码
     * @return 加密字符串
     */
    public static String encryptPassword(String password) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        return passwordEncoder.encode(password);
    }

    /**
     * 判断密码是否相同
     *
     * @param rawPassword     真实密码
     * @param encodedPassword 加密后字符
     * @return 结果
     */
    public static boolean matchesPassword(String rawPassword, String encodedPassword) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        return passwordEncoder.matches(rawPassword, encodedPassword);
    }
}
