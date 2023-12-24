package com.xmum.swe.entities.DTO;

import lombok.Data;

@Data
public class OrderPriceInfoDTO {

    //折前总价
    private float total_amount;

    private float discount_amount;
    //最终总价
    private float actual_amount;
    //数量 * 单价
    private float product_price;
}
