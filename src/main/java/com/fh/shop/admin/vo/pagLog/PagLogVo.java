package com.fh.shop.admin.vo.pagLog;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

@Data
public class PagLogVo implements Serializable {

    private String outTradeNo;//商品编号   雪花算法

    private Long memberId;//会员Id

    private String orderId;//订单ID    雪花算法

    private String transactionId;//交易流水号，第三方支付工具返回的

    private String payTime; //支付时间

    private BigDecimal payMoney;//支付价格

    private Integer payType;//支付类型

    private Integer payStatus;//支付状态

    private String createTime;//创建时间
}
