package com.xmum.swe.Interceptor;

import cn.hutool.core.util.ObjectUtil;
import com.alibaba.druid.util.StringUtils;
import com.xmum.swe.entities.DO.CustomerDO;
import com.xmum.swe.service.CustomerService;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.UUID;

@Component
public class LoginInterceptor implements HandlerInterceptor {

    @Resource
    private CustomerService customerService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Cookie[] cookies = request.getCookies();
        //if no cookie
        if (ObjectUtil.isNull(cookies)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        //if cookie exists, but no cookie_username
        String cookie_username = null;
        for (Cookie item : cookies) {
            if ("cookie_username".equals(item.getName())) {
                cookie_username = item.getValue();
                break;
            }
        }
        if (StringUtils.isEmpty(cookie_username)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        HttpSession session = request.getSession();
        //if session expired  自动续期
        Object obj = session.getAttribute("spookify-b2b-customer");
        if (ObjectUtil.isNull(obj)) {
            CustomerDO customerDO = customerService.getCustomerByName(cookie_username);
            session.setAttribute("spookify-b2b-customer", customerDO);
        }
        return true;
    }
}