package com.fh.shop.admin.mapper.member;

import com.fh.shop.admin.param.member.MemberParam;
import com.fh.shop.admin.po.member.Member;

import java.util.List;

public interface IMemberMapper {
    Long findCount(MemberParam memberParam);

    List<Member> findPageMemberList(MemberParam memberParam);
}
