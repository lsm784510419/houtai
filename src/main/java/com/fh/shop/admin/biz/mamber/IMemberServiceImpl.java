package com.fh.shop.admin.biz.mamber;

import com.fh.shop.admin.commons.Datetables;
import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.mapper.member.IMemberMapper;
import com.fh.shop.admin.param.member.MemberParam;
import com.fh.shop.admin.po.member.Member;
import com.fh.shop.admin.util.DateUtil;
import com.fh.shop.admin.vo.member.MemberVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("memberService")
public class IMemberServiceImpl implements IMemberService {
    @Autowired
    private IMemberMapper memberMapper;
    @Override
    public ServerRespones findPageMemberList(MemberParam memberParam) {
        Long count =  memberMapper.findCount(memberParam);
        List<Member> memberList = memberMapper.findPageMemberList(memberParam);
        List<MemberVo> memberVoList = getMemberVos(memberList);
        Datetables datetables = new Datetables(memberParam.getDraw(),count,count,memberVoList);
        return ServerRespones.success(datetables);
    }

    private List<MemberVo> getMemberVos(List<Member> memberList) {
        List<MemberVo> memberVoList = new ArrayList<>();
        for (Member member : memberList) {
            MemberVo memberVo = new MemberVo();
            memberVo.setId(member.getId());
            memberVo.setUserName(member.getUserName());
            memberVo.setRealName(member.getRealName());
            memberVo.setPhone(member.getPhone());
            memberVo.setBirthday(DateUtil.date2str(member.getBirthday(),DateUtil.Y_M_D));
            memberVo.setEmail(member.getEmail());
            memberVo.setAreaName(member.getAreaName());
            memberVoList.add(memberVo);
        }
        return memberVoList;
    }
}
