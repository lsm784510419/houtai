package com.fh.shop.admin.controller.member;

import com.fh.shop.admin.biz.mamber.IMemberService;
import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.param.member.MemberParam;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Resource(name = "memberService")
    private IMemberService memberService;

    @RequestMapping("/toList")
    public String toList(){
        return "member/list";
    }
    @RequestMapping("/findPageMemberList")
    @ResponseBody
    public ServerRespones findPageMemberList(MemberParam memberParam){

        return memberService.findPageMemberList(memberParam);
    }
}
