package com.fh.shop.admin.mapper.user;

import com.fh.shop.admin.param.user.ParamSearchUser;
import com.fh.shop.admin.param.user.UserParam;
import com.fh.shop.admin.po.user.User;
import com.fh.shop.admin.po.userrole.UserRole;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface IUserMapper {
    void addUser(User user);

    long findUserCount(ParamSearchUser userSearch);

    List<User> findUserList(ParamSearchUser userSearch);

    void deleteUser(Long id);

    User findUserUpdate(Long id);

    void updateUser(User user);

    void addUserRole(UserRole userRole);

    List<String> findUserRoleList(Long userId);

    List<Integer> findRoleIdList(Long id);

    void deleteUserRole(Long id);

    void deleteBatchUser(List<Long> list);

    void deleteUserRoles(List<Long> list);

    User login(String userName);

    List<User> downExcel(ParamSearchUser paramSearchUser);

    void updateLoginTime(@Param("id") Long id, @Param("currDate") Date date);

    void resetLoginCount(Long id);

    void updateLoginCount(Long id);

    void updateErrorLoginInfo(@Param("currDate") Date date, @Param("userId") Long id);

    void resetErrorLogin(@Param("currDate") Date date, @Param("userId") Long id);

    void updateErrorLoginCount(Long id);

    void updateErrorLoginDate(@Param("currDate") Date date, @Param("userId") Long id);

    void updatePassword(UserParam userParam);

    void resetPassword(@Param("id") Long id, @Param("pass") String password1);

    User findEmail(String mail);

    User verifyUserName(String userName);

    List<User> findexportUser(ParamSearchUser paramSearchUser);
}
