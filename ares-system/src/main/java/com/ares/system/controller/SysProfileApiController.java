package com.ares.system.controller;


import com.ares.core.controller.BaseController;
import com.ares.core.persistence.model.base.AjaxResult;
import com.ares.core.persistence.model.system.SysDept;
import com.ares.core.persistence.model.system.SysPost;
import com.ares.core.persistence.model.system.SysUser;
import com.ares.core.persistence.service.*;
import com.ares.core.utils.EncryptUtils;
import com.ares.core.utils.MD5Util;
import com.ares.system.common.shiro.ShiroUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

/**
 * 个人信息 业务处理
 */
@RestController
@RequestMapping("/system/user/profile/*")
@Api(value = "个人信息API", tags = {"个人信息"})
public class SysProfileApiController extends BaseController {
    @Autowired
    private SysUserService userService;
    @Autowired
    private UploadService uploadService;
    @Autowired
    private SysPropertiesService propertiesService;
    @Autowired
    private SysPostService postService;
    @Autowired
    private SysDeptService deptService;

    /**
     * 个人信息
     */
    @GetMapping("info")
    @ApiOperation(value = "获取个人信息", response = Object.class)
    public Object profile() throws Exception {
        SysUser user = ShiroUtils.getUser();
        SysDept sysDept = deptService.getById(user.getDeptId());
        SysPost sysPost = postService.getById(user.getPostId());
        AjaxResult result = AjaxResult.successData(user);
        result.put("roleGroup", userService.selectUserRoleGroup(user.getId()));
        result.put("deptGroup", null != sysDept ? sysDept.getDeptName() : "");
        result.put("postGroup", null != sysPost ? sysPost.getPostName() : "");
        return result;
    }

    /**
     * 修改用户
     */
    @PutMapping("update")
    @ApiOperation(value = "修改用户信息", response = Object.class)
    public Object updateProfile(@RequestBody SysUser user) {
        userService.update(user);
        ShiroUtils.setUser(user);
        return AjaxResult.success();
    }

    /**
     * 重置密码
     */
    @PutMapping("updatePwd")
    @ApiOperation(value = "重置密码", response = Object.class)
    public Object updatePwd(String oldPassword, String newPassword) throws Exception {
        SysUser user = ShiroUtils.getUser();
        if (!user.getPassword().equals(MD5Util.encode(oldPassword))) {
            return AjaxResult.error("修改密码失败，旧密码错误");
        }
        if (user.getPassword().equals(MD5Util.encode(newPassword))) {
            return AjaxResult.error("新密码不能与旧密码相同");
        }
        if (userService.updatePassword(user, newPassword) > 0) {
            user.setPassword(MD5Util.encode(newPassword));
            ShiroUtils.setUser(user);
            // 更新缓存用户密码
            return AjaxResult.success();
        }
        return AjaxResult.error("修改密码异常，请联系管理员");
    }

    /**
     * 头像上传
     */
    @PostMapping("avatar")
    @ApiOperation(value = "头像上传", response = Object.class)
    public Object avatar(@RequestParam("avatarfile") MultipartFile file) throws Exception {
        if (!file.isEmpty()) {
            SysUser user = ShiroUtils.getUser();
            String path = propertiesService.getValueByAlias("avatar.path");
            String avatar = uploadService.upload(path, file);
            user.setAvatar(EncryptUtils.encode(avatar));
            userService.update(user);
            return AjaxResult.success().put("imgUrl", EncryptUtils.encode(avatar));
        }
        return AjaxResult.error("上传图片异常，请联系管理员!");
    }

    @GetMapping("{path}")
    @ApiOperation(value = "获取头像")
    public void getAvatar(HttpServletRequest request, HttpServletResponse response, @PathVariable String path) throws Exception {
        File file = new File(EncryptUtils.decode(path));
        if (file.exists()) {
            FileInputStream fileInputStream = new FileInputStream(file);
            int i = fileInputStream.available(); // 得到文件大小
            byte data[] = new byte[i];
            fileInputStream.read(data); // 读数据
            fileInputStream.close();
            response.setContentType("image/*"); // 设置返回的文件类型
            OutputStream toClient = response.getOutputStream(); // 得到向客户端输出二进制数据的对象
            toClient.write(data); // 输出数据
            toClient.close();
        }
    }
}
