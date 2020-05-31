package com.atguigu.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;

/**
 * 测试dao层的工作
 * 
 * @author 12468 使用spring的项目就是用spring的单元测试，可以自动注入我们需要的组件 1、导入 springtest模块
 *         2、@ContextConfiguration指定spring配置的文件的位置 3、直接autowire
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:applicationContext.xml")
public class Mapper {

	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;

	@Test
	public void testCRUD() {

		/*
		 * // 1、创建springioc容器 ApplicationContext ac = new
		 * ClassPathXmlApplicationContext("classpath:applicationContext.xml"); //
		 * 2、从容器中获取对象 DepartmentMapper departmentMapper =
		 * ac.getBean(DepartmentMapper.class);
		 */

		System.out.println(departmentMapper);

		/*
		 * //插入部门 departmentMapper.insertSelective(new Department(null, "开发部"));
		 * departmentMapper.insertSelective(new Department(null, "测试部"));
		 */
		// 插入员工
		// employeeMapper.insertSelective(new Employee(null, "张三", "男",
		// "124682726@qq.com", 1));
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 1000; i++) {
			String uuid = UUID.randomUUID().toString().substring(0, 5);
			mapper.insertSelective(new Employee(null, uuid, "m", uuid + "@qq.com", 1));
		}
		System.out.println("批量成");
	}
}
