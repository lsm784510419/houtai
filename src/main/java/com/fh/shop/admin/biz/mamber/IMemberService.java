package com.fh.shop.admin.biz.mamber;

import com.fh.shop.admin.commons.ServerRespones;
import com.fh.shop.admin.param.member.MemberParam;

public interface IMemberService {
    ServerRespones findPageMemberList(MemberParam memberParam);
}
