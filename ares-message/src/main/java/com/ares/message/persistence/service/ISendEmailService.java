package com.ares.message.persistence.service;

import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/06/08
 **/
public interface ISendEmailService {

    public void sendEmail() ;

    public void send(String template, List<String> receivers, Map<String, Object> vars) ;

}
