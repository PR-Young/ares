package com.ares.core.persistence.service.impl;

import com.ares.core.persistence.dao.ISysRoleDao;
import com.ares.core.persistence.dao.ISysUserDao;
import com.ares.core.persistence.model.system.SysRole;
import com.ares.core.persistence.model.system.SysUser;
import com.ares.core.persistence.service.ISysUserService;
import com.ares.core.utils.MD5Util;
import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.core.utils.StringUtils;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

/**
 * @description:
 * @author: Young 2020/01/22
 **/
@Service
public class SysUserServiceImpl implements ISysUserService {

    private ISysUserDao sysUserDao;
    private ISysRoleDao roleDao;

    @Autowired
    public SysUserServiceImpl(ISysUserDao sysUserDao, ISysRoleDao roleDao) {
        this.sysUserDao = sysUserDao;
        this.roleDao = roleDao;
    }

    @Override
    public void insert(SysUser sysUser) {
        sysUser.setId(SnowflakeIdWorker.getUUID());
        sysUser.setPassword(MD5Util.encode("123456"));
        sysUser.setCreateTime(new Date());
        sysUserDao.insert(sysUser);
    }

    @Override
    public PageInfo<SysUser> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysUser> userList = sysUserDao.list(map);
        PageInfo<SysUser> userPageInfo = new PageInfo<>(userList);
        return userPageInfo;
    }

    @Override
    public List<SysUser> list(SysUser obj) {
        return null;
    }

    @Override
    public List<SysUser> assignAllUser(String roleId) {
        List<SysUser> userList = sysUserDao.allUser(roleId);
        return userList;
    }

    @Override
    public List<SysUser> getUserByRole(String roleId) {
        List<SysUser> userList = sysUserDao.getUserByRole(roleId);
        return userList;
    }

    @Override
    public void update(SysUser obj) {
        obj.setModifyTime(new Date());
        sysUserDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        sysUserDao.deleteByIds(ids);
    }

    @Override
    public SysUser getById(String id) {
        return sysUserDao.getById(id);
    }

    @Override
    public int checkAccount(String account) {
        Integer num = sysUserDao.checkAccount(account);
        return num == null ? 0 : num;
    }

    @Override
    public int resetPassword(String id) {
        return sysUserDao.resetPassword(MD5Util.encode("123456"), id);
    }

    @Override
    public List<SysUser> selectUserList(SysUser user) {
        return sysUserDao.selectList(user);
    }

    @Override
    public String insertUser(SysUser sysUser) {
        String id = SnowflakeIdWorker.getUUID();
        sysUser.setId(id);
        sysUser.setPassword(MD5Util.encode("123456"));
        sysUser.setCreateTime(new Date());
        sysUserDao.insert(sysUser);
        return id;
    }

    @Override
    public String selectUserRoleGroup(String userId) {
        List<SysRole> roleList = roleDao.getRoleByUserId(userId);
        StringBuffer idsStr = new StringBuffer();
        for (SysRole role : roleList) {
            idsStr.append(role.getDescription()).append(",");
        }
        if (StringUtils.isNotEmpty(idsStr.toString())) {
            return idsStr.substring(0, idsStr.length() - 1);
        }
        return idsStr.toString();
    }

    @Override
    public int updatePassword(SysUser user, String passWord) {
        user.setPassword(MD5Util.encode(passWord));
        return sysUserDao.update(user);
    }

    @Override
    public SysUser getUserByName(String userName) {
        return sysUserDao.getUserByName(userName);
    }

    @Override
    public int updateUserByAccount(SysUser sysUser) {
        return sysUserDao.updateUserByAccount(sysUser);
    }

    @Override
    public boolean saveBatch(Collection entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdateBatch(Collection entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean updateBatchById(Collection entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdate(Object entity) {
        return false;
    }

    @Override
    public Object getOne(Wrapper queryWrapper, boolean throwEx) {
        return null;
    }

    @Override
    public Map<String, Object> getMap(Wrapper queryWrapper) {
        return null;
    }

    @Override
    public BaseMapper getBaseMapper() {
        return null;
    }

    @Override
    public Class getEntityClass() {
        return null;
    }

    @Override
    public Object getObj(Wrapper queryWrapper, Function mapper) {
        return null;
    }


}
