package com.fh.shop.admin.biz;

import com.fh.shop.admin.biz.user.IUserService;
import com.fh.shop.admin.param.user.ParamSearchUser;
import com.fh.shop.admin.po.user.User;
import com.fh.shop.admin.vo.user.UserVo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-common.xml"})
public class TestService extends AbstractJUnit4SpringContextTests {

    @Resource(name= "userService")
    private IUserService userService;
    @Test
    public void testAddUser(){
        User user = new User();
        user.setUserName("xiaohuizi");
        user.setRealName("张佳慧");
        userService.addUser(user);
    }
    @Test
    public void testDelete(){
        userService.deleteUser(87L);
    }
   @Test
    public void testUpdate(){
        User user = new User();
        user.setId(88L);
        user.setUserName("dahuizi");
        userService.updateUser(user);
    }
    @Test
    public void testList(){
        ParamSearchUser paramSearchUser = new ParamSearchUser();
        paramSearchUser.setDraw(1);
        paramSearchUser.setStart(0);
        paramSearchUser.setLength(6);

        List<UserVo> userList = userService.findUserList(paramSearchUser);
        System.out.println(userList);
    }
}
